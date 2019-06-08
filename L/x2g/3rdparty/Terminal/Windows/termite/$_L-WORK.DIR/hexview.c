/*  Termite filter: Display received text as a hex dump
 *
 *  Copyright (c) CompuPhase, 2008-2012
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
#include <windows.h>
#include "textbuffer.h"
#include "hexview.h"


#define FLTEXPORT __declspec(dllexport) __stdcall

#if !defined sizearray
  #define sizearray(a)  (sizeof(a) / sizeof((a)[0]))
#endif

    /* a few strings that are used in various locations */
const char strCaption[] = "HexView filter";
const char strSection[] = "HexView";
const char strDisplay[] = "display";
const char strEntry[] = "entry";
const char strPrefix[] = "prefix";
const char strLowByteFirst[] = "lowbytefirst";
const char strBytesPerLine[] = "bytesperline";


    /* forward declarations of a few functions */
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
static LPSTR MakeString(LPSTR String, LPBYTE Buffer, int BufferSize);
static int hexdigit(char c);

    /* constants */
#define MAX_BYTESPERLINE  80
#define LINELENGTH(BytesPerRow) \
                      (BytesPerRow * 3 + 1     + BytesPerRow + 1  + 1 )
                      /* 3 hex digits  + space + ASCII char  + CR + LF */

    /* this variable is declared in dllmain.c */
extern HINSTANCE hinstDLL;

    /* a few global variables for this particular filter */
static unsigned char Buffer[MAX_BYTESPERLINE];
static int BufferSize = 0;
static BOOL HexDisplay;
static BOOL HexEntry;
static char HexPrefix[10];
static BOOL HexLBF;
static int BytesPerLine;

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
  HexDisplay = (BOOL)GetPrivateProfileInt(strSection, strDisplay, 1, ProfileFile);
  HexEntry = (BOOL)GetPrivateProfileInt(strSection, strEntry, 1, ProfileFile);
  BytesPerLine = GetPrivateProfileInt(strSection, strBytesPerLine, 16, ProfileFile);
  GetPrivateProfileString(strSection, strPrefix, "0x", HexPrefix, sizearray(HexPrefix), ProfileFile);
  HexLBF = GetPrivateProfileInt(strSection, strLowByteFirst, 0, ProfileFile);

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
  int numbytes, numpackets;
  LPSTR BufPtr, Ptr;

  /* early exit if hex display has been disabled */
  if (!HexDisplay)
    return NULL;

  /* count how much data we have and how big the text buffer must be (always
   * allocate for one extra line, for simplicity)
   */
  numbytes = BufferSize + *Size;
  numpackets = numbytes / BytesPerLine;
  BufPtr = txtbuf_Alloc((numpackets + 1) * LINELENGTH(BytesPerLine));
  if (BufPtr == NULL)
    return NULL;  /* this can also happen if both BufferSize & *Size are zero */
  Ptr = BufPtr;

  if (*Size == 0) {
    /* special case, if *Size is zero on input, return the buffered data */
    MakeString(Ptr, Buffer, BufferSize);
    BufferSize = 0;
    *Size = LINELENGTH(BytesPerLine);
  } else {
    /* standard case: data was received */
    while (*Size > 0) {
      /* collect up to 16 bytes from the text */
      while (*Size > 0 && BufferSize < BytesPerLine) {
        Buffer[BufferSize++] = *Text++;
        *Size -= 1;
      } /* while */
      /* if a full line was collected, append this as hex to the text buffer */
      if (BufferSize == BytesPerLine) {
        Ptr = MakeString(Ptr, Buffer, BufferSize);
        BufferSize = 0;     /* clear buffer again */
      } /* if */
    } /* while */
    *Size = numpackets * LINELENGTH(BytesPerLine);
    assert(*Size == (int)(Ptr - BufPtr));
  } /* if */

  return BufPtr;
}

/* flt_Transmit() is called before Termite transmits data that the user has
 * typed in.
 *
 * Text         The contents of the data to be transmitted.
 * Size         On input, this parameter points to the size of the data block
 *              that parameter "Text" holds. Note that the data in "Text" need
 *              to be zero-terminated. On output, this parameter must hold the
 *              new size of the data block.
 *
 * If flt_Transmit() does not change the string, it can return NULL or return
 * the original string.
 *
 * If the result of flt_Transmit() is a shorter string than the input string,
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
LPCSTR FLTEXPORT flt_Transmit(LPCSTR Text, LPINT Size)
{
  LPSTR BufPtr;
  int idx, length, start;
  int prefixlen;

  /* early exit if hex entry has been disabled */
  if (!HexEntry)
    return NULL;

  /* allocate buffer space (the string can only become smaller in this
   * conversion, so by allocating the size of the input buffer, we may
   * allocate too much, but not too little
   */
  BufPtr = txtbuf_Alloc(*Size);
  if (BufPtr == NULL)
    return NULL;

  /* parse the string */
  length = 0;
  idx = 0;
  prefixlen = strlen(HexPrefix);
  while (idx < *Size) {
    /* see if the current text starts with the configured prefix, and followed
     * by at least two hexadecimal digits
     */
    if (idx + prefixlen + 2 <= *Size && strnicmp(Text+idx,HexPrefix,prefixlen) == 0
        && hexdigit(Text[idx + prefixlen]) >= 0 && hexdigit(Text[idx + prefixlen + 1]) >= 0)
    {
      idx += prefixlen; /* skip "0x" (or any other prefix) */
      start = length;   /* mark the start of the hexadecimal section in the output buffer */
      BufPtr[length++] = (char)((hexdigit(Text[idx]) << 4) | hexdigit(Text[idx + 1]));
      idx += 2;         /* skip first two hexadecimal digits */
      /* parse more hexadecimal values (these must be in pairs) */
      while (idx + 2 <= *Size
             && hexdigit(Text[idx]) >= 0 && hexdigit(Text[idx + 1]) >= 0)
      {
        BufPtr[length++] = (char)((hexdigit(Text[idx]) << 4) | hexdigit(Text[idx + 1]));
        idx += 2;
      } /* while */
      if (Text[idx] == ' ')
        idx++;    /* ignore a single space after a hexadecimal value */
      if (HexLBF) {
        /* swap all bytes between the start and the end of the hex section */
        int i = start, j = length - 1;
        while (i < j) {
          char tmp = BufPtr[i];
          BufPtr[i] = BufPtr[j];
          BufPtr[j] = tmp;
          i++;
          j--;
        }
      }
    } else {
      BufPtr[length++] = Text[idx];
      idx++;
    } /* if */
  } /* while */

  *Size = length;
  return BufPtr;
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
    /* save the new settings back to the INI file */
    char valuestr[10];
    wsprintf(valuestr, "%d", HexDisplay);
    WritePrivateProfileString(strSection, strDisplay, valuestr, ProfileFile);
    wsprintf(valuestr, "%d", HexEntry);
    WritePrivateProfileString(strSection, strEntry, valuestr, ProfileFile);
    WritePrivateProfileString(strSection, strPrefix, HexPrefix, ProfileFile);
    wsprintf(valuestr, "%d", HexLBF);
    WritePrivateProfileString(strSection, strLowByteFirst, valuestr, ProfileFile);
    wsprintf(valuestr, "%d", BytesPerLine);
    WritePrivateProfileString(strSection, strBytesPerLine, valuestr, ProfileFile);
  } /* if */

  return (result == IDOK);
}


#pragma argsused
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  int val;
  BOOL ok;

  switch (msg) {
  case WM_INITDIALOG:
    /* copy current settings into the controls */
    CheckDlgButton(hwnd, IDD_HEXENTRY, HexEntry ? BST_CHECKED : BST_UNCHECKED);
    CheckDlgButton(hwnd, IDD_HEXDISPLAY, HexDisplay ? BST_CHECKED : BST_UNCHECKED);
    CheckDlgButton(hwnd, IDD_HEXLBF, HexLBF ? BST_CHECKED : BST_UNCHECKED);
    SetDlgItemInt(hwnd, IDD_BYTESPERLINE, BytesPerLine, FALSE);
    SetDlgItemText(hwnd, IDD_HEXPREFIX, HexPrefix);
    return TRUE;

  case WM_COMMAND:
    switch (LOWORD(wParam)) {
    case IDCANCEL:
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDOK:
      /* copy edited fields back to the global variables */
      HexEntry = IsDlgButtonChecked(hwnd, IDD_HEXENTRY) == BST_CHECKED;
      HexDisplay = IsDlgButtonChecked(hwnd, IDD_HEXDISPLAY) == BST_CHECKED;
      HexLBF = IsDlgButtonChecked(hwnd, IDD_HEXLBF) == BST_CHECKED;
      val = GetDlgItemInt(hwnd, IDD_BYTESPERLINE, &ok, FALSE);
      if (ok && val > 0 && val <= MAX_BYTESPERLINE)
        BytesPerLine = val;
      GetDlgItemText(hwnd, IDD_HEXPREFIX, HexPrefix, sizearray(HexPrefix));
      /* quick checks for extra usage notes */
      if (!HexEntry && !HexDisplay) {
        MessageBox(hwnd, "Hexadecimal entry and hexadecimal display are both disabled.\n"
                         "You might as well disable (i.e. unload) the filter entirely.\n",
                   strCaption, MB_OK | MB_ICONINFORMATION);
      } /* if */
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDHELP:
      DialogBox(hinstDLL, "FilterInfo", hwnd, (DLGPROC)FilterInfoDlg);
      return TRUE;
    case IDD_HEXENTRY:
      ok = IsDlgButtonChecked(hwnd, IDD_HEXENTRY) == BST_CHECKED;
      EnableWindow(GetDlgItem(hwnd, IDD_HEXPREFIX), ok);
      EnableWindow(GetDlgItem(hwnd, IDD_HEXLBF), ok);
      break;
    case IDD_HEXDISPLAY:
      ok = IsDlgButtonChecked(hwnd, IDD_HEXENTRY) == BST_CHECKED;
      EnableWindow(GetDlgItem(hwnd, IDD_BYTESPERLINE), ok);
      break;
    } /* switch */
    break;
  } /* switch */

  return FALSE;
}

#pragma argsused
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
static const
#include "hexview-help.c"

  switch (msg) {
  case WM_INITDIALOG:
    SetDlgItemText(hwnd, INFOTEXT, helpstring);
    return TRUE;
  case WM_COMMAND:
    switch (LOWORD(wParam)) {
    case IDCANCEL:
    case IDOK:
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    } /* switch */
  } /* switch */

  return FALSE;
}


static LPSTR MakeString(LPSTR String, LPBYTE Buffer, int BufferSize)
{
  int idx;

  for (idx = 0; idx < BufferSize; idx++) {
    wsprintf(String, "%02x ", Buffer[idx]);
    String += 3;
  } /* for */
  for ( ; idx < BytesPerLine; idx++) {
    strcpy(String, "   ");
    String += 3;
  } /* for */

  *String++ = ' ';    /* extra separator */
  for (idx = 0; idx < BufferSize; idx++)
    *String++ = (Buffer[idx] >= ' ' ? Buffer[idx] : '.');
  for ( ; idx < BytesPerLine; idx++)
    *String++ = ' ';

  *String++ = '\r';   /* CR */
  *String++ = '\n';   /* LF */

  return String;
}

static int hexdigit(char c)
{
  if (c >= '0' && c <= '9')
    return c - '0';
  if (c >= 'A' && c <= 'F')
    return c - 'A' + 10;
  if (c >= 'a' && c <= 'f')
    return c - 'a' + 10;
  return -1;
}
