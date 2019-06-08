/*  Termite filter: Append received text to a log file
 *
 *  Copyright (c) CompuPhase, 2010-2012
 *
 *  This software is provided "as-is", without any express or implied warranty.
 *  In no event will the authors be held liable for any damages arising from
 *  the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute it
 *  freely, subject to the following restrictions:
 *
 *  1.  The origin of this software must not be misrepresented; you must not
 *      claim that you wrote the original software. If you use this software in
 *      a product, an acknowledgment in the product documentation would be
 *      appreciated but is not required.
 *  2.  Altered source versions must be plainly marked as such, and must not be
 *      misrepresented as being the original software.
 *  3.  This notice may not be removed or altered from any source distribution.
 */

#include <assert.h>
#include <stdio.h>
#include <time.h>
#include <windows.h>
#include "logfile.h"

#define FLTEXPORT __declspec(dllexport) __stdcall

#if !defined sizearray
  #define sizearray(a)  (sizeof(a) / sizeof((a)[0]))
#endif

    /* a few strings that are used in various locations */
const char strCaption[] = "LogFile filter";
const char strSection[] = "LogFile";
const char strFilename[] = "filename";
const char strBinaryMode[] = "binarymode";


    /* forward declarations of a few functions */
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
static BOOL PickFile(HWND hwnd, LPSTR filename, int max);
static FILE *open_with_error(const char *filename);

    /* constants */

    /* this variable is declared in dllmain.c */
extern HINSTANCE hinstDLL;

    /* a few global variables for this particular filter */
static char LogFilename[_MAX_PATH];
static BOOL BinaryMode;
static FILE *fpLog;
static BOOL LogTested;

static HWND hwndTermite;
static char ProfileFile[_MAX_PATH];


/* flt_Load() is called when Termite loads the filter.
 *
 * hwnd         The handle to the main window of Termite.
 * ProfileName  The full path to the INI file that Termite uses. The filter
 *              can use this name to store its configuration.
 * Build        The build number of Termite, for distinguishing versions of
 *              the Termite application.
 *
 * This function must return TRUE if it can load successfully. If the function
 * returns FALSE, Termite will unload it.
 */
BOOL FLTEXPORT flt_Load(HWND hwnd, LPCSTR ProfileName, int Build)
{
  (void)hwnd;           /* these parameters are not used */
  (void)Build;

  /* read settings (from the same INI file as Termite uses) */
  strcpy(ProfileFile, ProfileName); /* save name of the INI file */
  GetPrivateProfileString(strSection, strFilename, "", LogFilename, sizearray(LogFilename), ProfileFile);
  BinaryMode = (BOOL)GetPrivateProfileInt(strSection, strBinaryMode, 0, ProfileFile);

  hwndTermite = hwnd;
  fpLog = NULL;
  LogTested = FALSE;

  return TRUE;
}


/* flt_Unload() is called when Termite removes the filter.
 *
 * After calling this notification function, Termite will physically unload
 * the filter DLL.
 *
 * For filters that allocate dynamic memory or other resources, this is a good
 * moment to free these resources.
 */
void FLTEXPORT flt_Unload(void)
{
  if (fpLog != NULL)
    fclose(fpLog);
}


/* flt_Receive() is called after Termite has received new data. It is also
 * called after not receiving data for some time-out (which is hard-coded to
 * 0.5 second). If a plug-in buffers data internally, this time-out allows the
 * plug-in to parse the remaining data.
 *
 * Text         The contents of the received data.
 * Size         On input, this parameter points to the size of the data block
 *              that parameter "Text" holds. Note that the data in "Text" need
 *              not be zero-terminated. On output, this parameter must hold the
 *              new size of the data block.
 *              This parameter may be zero on input, so that the plug-in can
 *              pass any data that it had buffered internally to Termite.
 *
 * If flt_Receive() does not change the string, it can return NULL or return
 * the original string.
 *
 * If the result of flt_Receive() is a shorter string than the input string,
 * the function may change the string in place (but this is not encouraged).
 * If the string changes (and especially if the result is bigger than the input
 * string), the function should allocate memory for the modified string. The
 * function should also keep track of the allocated memory, because it must
 * free the memory itself: either on a next call, or on flt_Unload(). It is
 * suggested that the filter creates an auto-growing output buffer.
 *
 * If the filter wishes to remove all data, it must set parameter "Size" to
 * zero on output. It should return a pointer to the input buffer (parameter
 * "Text"); specifically, it should not return NULL.
 *
 * The input and output strings are not necessarily zero-terminated; the
 * filter must adjust the length to the number of bytes it returns (parameter
 * "Size").
 */
LPCSTR FLTEXPORT flt_Receive(LPCSTR Text, LPINT Size)
{
  if (fpLog == NULL && !LogTested)
    fpLog = open_with_error(LogFilename);

  if (fpLog != NULL && *Size > 0) {
    if (BinaryMode) {
      int idx;
      for (idx = 0; idx < *Size; idx++)
        if (Text[idx] >= ' ' || Text[idx] == '\r' || Text[idx] == '\n' || Text[idx] == '\t')
          fwrite(Text + idx, 1, 1, fpLog);
    } else {
      fwrite(Text, 1, *Size, fpLog);
    } /* if */
    fflush(fpLog);
  } /* if */

  return NULL;
}


/* flt_Config() is called when the user chooses to configure the filter.
 *
 * This function must return TRUE if the configuration was successfully changed,
 * and FALSE if the user cancelled the operation or if there was an error.
 */
BOOL FLTEXPORT flt_Config(void)
{
  int result;

  /* pop up the dialog for configuration */
  result = DialogBox(hinstDLL, "FilterConfig", GetFocus(), (DLGPROC)FilterConfigDlg);
  if (result == IDOK) {
    char value[10];

    WritePrivateProfileString(strSection, strFilename, LogFilename, ProfileFile);
    wsprintf(value, "%d", BinaryMode);
    WritePrivateProfileString(strSection, strBinaryMode, value, ProfileFile);

    /* close the current file and open the new file */
    if (fpLog!=NULL) {
      fclose(fpLog);
      fpLog=NULL;
    } /* if */
    fpLog = open_with_error(LogFilename);
  } /* if */

  return (result == IDOK);
}


BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  char str[_MAX_PATH];

  switch (msg) {
  case WM_INITDIALOG:
    /* copy current settings into the controls */
    SetDlgItemText(hwnd, ID_FILENAME, LogFilename);
    CheckDlgButton(hwnd, ID_BINARYMODE, BinaryMode ? BST_CHECKED : BST_UNCHECKED);
    return TRUE;

  case WM_COMMAND:
    switch (LOWORD(wParam)) {
    case IDCANCEL:
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDOK:
      /* copy edited fields back to the global variables */
      GetDlgItemText(hwnd, ID_FILENAME, LogFilename, sizearray(LogFilename));
      BinaryMode = IsDlgButtonChecked(hwnd, ID_BINARYMODE) == BST_CHECKED;
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case ID_PICKFILE:
      GetDlgItemText(hwnd, ID_FILENAME, str, sizearray(str));
      if (PickFile(hwnd, str, sizearray(str)))
        SetDlgItemText(hwnd, ID_FILENAME, str);
      return TRUE;
    } /* switch */
    break;
  } /* switch */

  return FALSE;
}


static BOOL PickFile(HWND hwnd, LPSTR filename, int max)
{
  OPENFILENAME ofn;

  memset(&ofn,0,sizeof ofn);
  ofn.lStructSize=sizeof ofn;
  ofn.hwndOwner=hwnd;
  ofn.lpstrFilter="Text files (*.txt, *.log)\0*.txt;*.log\0"
                  "Binary files (*.bin)\0*.bin\0"
                  "All files (*.*)\0*.*\0";
  ofn.nFilterIndex=1;
  ofn.lpstrFile=filename;
  ofn.nMaxFile=max;
  ofn.Flags=OFN_CREATEPROMPT;

  return GetSaveFileName(&ofn);
}


static FILE *open_with_error(const char *filename)
{
  if (LogTested)
    return fpLog;
  LogTested = TRUE;

  if (strlen(filename) == 0) {
    MessageBox(hwndTermite, "No log file was chosen, logging is disabled.\nConfigure the LogView plug-in to enable logging.", strSection, MB_OK | MB_ICONEXCLAMATION);
    return NULL;
  } /* if */

  fpLog = fopen(LogFilename, "ab");
  if (fpLog == NULL) {
    MessageBox(hwndTermite, "Failed to open the log file, logging is disabled.\nConfigure the LogView plug-in to enable logging.", strSection, MB_OK | MB_ICONEXCLAMATION);
  } else if (!BinaryMode) {
    time_t t;
    time(&t);
    fprintf(fpLog,"\r\n"
                  "**********************************************************\r\n"
                  "Termite log, started at %s"
                  "**********************************************************\r\n",
                  ctime(&t));
  } /* if */

  return fpLog;
}
