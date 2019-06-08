/*  Termite filter: add a timestamp to received text
 *
 *  Copyright (c) CompuPhase, 2008-2011
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

#include <windows.h>
#include <string.h>
#include "textbuffer.h"

#define FLTEXPORT __declspec(dllexport) __stdcall


    /* a few strings that are used in various locations */
const char strSection[] = "Timestamp";
const char strInterval[] = "interval";
const char strPrecision[] = "precision";
const char strAbsTime[] = "absolute";


    /* forward declarations of a few functions */
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
static void formattimestamp(char *string, DWORD delta);
static void formattime(char *string);


    /* this variable is declared in dllmain.c */
extern HINSTANCE hinstDLL;

    /* a few global variables for this particular filter */
static int TimestampInterval;
static int TimestampPrecision;
static int TimestampAbsolute;
static DWORD tsFirstReception, tsLastReception;
static BOOL TailNewline;

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
  TimestampInterval = GetPrivateProfileInt(strSection, strInterval, 1000, ProfileFile);
  TimestampPrecision = GetPrivateProfileInt(strSection, strPrecision, 1000, ProfileFile);
  TimestampAbsolute = GetPrivateProfileInt(strSection, strAbsTime, 0, ProfileFile);
  tsFirstReception = 0;
  TailNewline = FALSE;

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
  /* free text buffer */
  txtbuf_Free();
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
    char valuestr[10];
    /* save the new settings back to the INI file */
    wsprintf(valuestr, "%d", TimestampInterval);
    WritePrivateProfileString(strSection, strInterval, valuestr, ProfileFile);
    wsprintf(valuestr, "%d", TimestampPrecision);
    WritePrivateProfileString(strSection, strPrecision, valuestr, ProfileFile);
    wsprintf(valuestr, "%d", TimestampAbsolute);
    WritePrivateProfileString(strSection, strAbsTime, valuestr, ProfileFile);
  } /* if */

  return (result == IDOK);
}


/* flt_Receive() is called after Termite has received new data. It is also
 * called after not receiving data for some time-out (which is hard-coded to
 * 0.5 second). If a plug-in buffers data internally, this time-out allows the
 * plug-in to parse the remaining data.
 *
 * Text         The contents of the received data.
 * Size         On input, this parameter points to the size of the data block
 *              that parameter "Text" holds. Note that the data in "Text" need
 *              to be zero-terminated. On output, this parameter must hold the
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
  char timestamp[40] = "";
  int extralength;
  BOOL tailnl;

  if (*Size <= 0)
    return NULL;

  tailnl = (Text[*Size - 1] == '\r' || Text[*Size - 1] == '\n');

  /* create a timestamp */
  if (TimestampInterval != 0) {
    DWORD stamp = timeGetTime();
    DWORD delta = stamp - tsLastReception;
    if (tsFirstReception > 0) {
      if (delta >= TimestampInterval) {
        if (TimestampAbsolute)
          formattime(timestamp);
        else
          formattimestamp(timestamp, stamp - tsFirstReception);
        tsLastReception = stamp;
      }
    } else {
      tsFirstReception = stamp;
      tsLastReception = stamp;
      if (TimestampAbsolute)
        formattime(timestamp);
      else
        formattimestamp(timestamp, 0);
    }
  }

  /* insert it before the text, or just after the first newline if an embedded
   * newline is present
   */
  if ((extralength = strlen(timestamp)) > 0) {
    LPSTR BufPtr, Ptr;
    int InsertPos = 0;
    /* first see whether a newline must be forced */
    Ptr = strchr(Text, '\n');
    if (Ptr == NULL)
      Ptr = strchr(Text, '\r');
    if (!TailNewline && (Ptr == NULL || *(Ptr + 1) != '\0')) {
      /* prefix a newline in front of the timestamp */
      extralength += 1;
      memmove(timestamp + 1, timestamp, extralength);
      *timestamp = '\n';
    } else if (!TailNewline) {
      /* if a newline is found in the text (and other text follows), insert
       * the time stamp behind the newline (all text in the buffer has the same
       * time stamp)
       */
      InsertPos = (int)(Ptr - Text) + 1;
    }
    BufPtr = txtbuf_Alloc(extralength + *Size);
    if (BufPtr != NULL) {
      if (InsertPos == 0) {
        memcpy(BufPtr, timestamp, extralength);
        memmove(BufPtr + extralength, Text, *Size);
      } else {
        memcpy(BufPtr, Text, *Size);
        memmove(BufPtr + InsertPos + extralength, BufPtr + InsertPos, *Size - InsertPos);
        memcpy(BufPtr + InsertPos, timestamp, extralength);
      }
      *Size += extralength;
    } /* if */
    TailNewline = tailnl;
    return BufPtr;
  } /* if */

  TailNewline = tailnl;
  return NULL;
}


static void formattimestamp(char *string, DWORD delta)
{
  DWORD milli = delta % 1000;
  DWORD seconds = (delta / 1000) % 60;
  DWORD minutes = (delta / (1000 * 60)) % 60;
  DWORD hours = (delta / (1000 * 60 * 60)) % 24;
  DWORD days = delta / (1000 * 60 * 60 * 24);
  int digits = (TimestampPrecision < 10) ? 3 : ((TimestampPrecision < 100) ? 2 : ((TimestampPrecision < 1000) ? 1 : 0));
  *string = '\0';
  if (days > 0)
    wsprintf(string + strlen(string), "%d:", days);
  if (hours > 0)
    wsprintf(string + strlen(string), "%02d:", hours);
  if (minutes > 0)
    wsprintf(string + strlen(string), "%02d:", minutes);
  switch (digits) {
  case 3:
    wsprintf(string + strlen(string), "%02d.%03d: ", seconds, milli);
    break;
  case 2:
    wsprintf(string + strlen(string), "%02d.%02d: ", seconds, milli/10);
    break;
  case 1:
    wsprintf(string + strlen(string), "%02d.%d: ", seconds, milli/100);
    break;
  default:
    wsprintf(string + strlen(string), "%02d: ", seconds);
  } /* switch */
}

static void formattime(char *string)
{
  SYSTEMTIME systime;
  int digits;

  GetLocalTime(&systime);
  wsprintf(string, "%02d:%02d:%02d", systime.wHour, systime.wMinute, systime.wSecond);
  digits = (TimestampPrecision < 10) ? 3 : ((TimestampPrecision < 100) ? 2 : ((TimestampPrecision < 1000) ? 1 : 0));
  switch (digits) {
  case 3:
    wsprintf(string + strlen(string), ".%03d: ", systime.wMilliseconds);
    break;
  case 2:
    wsprintf(string + strlen(string), ".%02d: ", systime.wMilliseconds/10);
    break;
  case 1:
    wsprintf(string + strlen(string), ".%d: ", systime.wMilliseconds/100);
    break;
  } /* switch */
}

#pragma argsused
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  char str[40];

  switch (msg) {
  case WM_INITDIALOG:
    /* copy current settings into the controls */
    wsprintf(str, "%d.%03d", TimestampInterval/1000, TimestampInterval%1000);
    SetDlgItemText(hwnd, 100, str);
    wsprintf(str, "%d.%03d", TimestampPrecision/1000, TimestampPrecision%1000);
    SetDlgItemText(hwnd, 101, str);
    CheckDlgButton(hwnd, 102+TimestampAbsolute, BST_CHECKED);
    return TRUE;

  case WM_COMMAND:
    switch (LOWORD(wParam)) {
    case IDCANCEL:
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDOK:
      /* copy edited fields back to the global variables */
      GetDlgItemText(hwnd, 100, str, sizeof str);
      TimestampInterval = (int)(atof(str) * 1000);
      GetDlgItemText(hwnd, 101, str, sizeof str);
      TimestampPrecision = (int)(atof(str) * 1000);
      TimestampAbsolute = IsDlgButtonChecked(hwnd, 103) == BST_CHECKED;
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    } /* switch */
    break;
  } /* switch */

  return FALSE;
}
