/*  Termite filter: highlight text that matches a pattern
 *
 *  Copyright (c) CompuPhase, 2014
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
 *
 *  Nota Bene:
 *  This software uses the "Super Light Regular Expression" library by Sergey
 *  Lyubka. This library is distributed under the terms of the GNU General
 *  Public License version 2.
 *
 *  That is: the source code of the Termite "Highlight" filter is subject to the
 *  zlib/libpng license (as mentioned above) and the SLRE source code is subject
 *  to the GPL version 2.
 */

#include <assert.h>
#include <windows.h>
#include <string.h>
#include "slre.h"
#include "textbuffer.h"
#include "highlight.h"


#define FLTEXPORT __declspec(dllexport) __stdcall

#if !defined sizearray
  #define sizearray(a)  (sizeof(a) / sizeof((a)[0]))
#endif

    /* a few strings that are used in various locations */
const char strCaption[] = "Highlight filter";
const char strSection[] = "Highlight";
const char strExprKey[] = "expression%d";

    /* the fixed colour table (15 used colours, one "default" colour) */
static const COLORREF Colour[16] = {
  RGB(0, 0, 255),     RGB(0, 0, 0),       RGB(128, 0, 0),     RGB(0, 128, 0),
  RGB(128, 128, 0),   RGB(0, 0, 128),     RGB(128, 0, 128),   RGB(0, 128, 128),
  RGB(128, 128, 128), RGB(192, 192, 192), RGB(255, 0, 0),     RGB(0, 255, 0),
  RGB(255, 255, 0),   RGB(0, 0, 255),     RGB(255, 0, 255),   RGB(0, 255, 255)
};

    /* forward declarations of a few functions */
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK ColourSelectDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
int match(const char *string, int length, int *start, int *end, int *scanned);


    /* this variable is declared in dllmain.c */
extern HINSTANCE hinstDLL;

    /* a few global variables for this particular filter */
#define NUM_EXPRESSIONS (IDD_MATCH5 - IDD_MATCH1 + 1)
#define MAX_EXPR_LEN    128
static char Expression[NUM_EXPRESSIONS][MAX_EXPR_LEN];
static int ColourIdx[NUM_EXPRESSIONS];
static int BufferSize = 0;
static int BufferRemove = 0;

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
  int idx;
  char key[20], value[MAX_EXPR_LEN + 16];
  char *ptr;

  (void)hwnd;           /* these parameters are not used */
  (void)Build;

  /* read settings (from the same INI file as Termite uses) */
  strcpy(ProfileFile, ProfileName); /* save name of the INI file */
  for (idx = 0; idx < NUM_EXPRESSIONS; idx++) {
    wsprintf(key, strExprKey, idx + 1);
    GetPrivateProfileString(strSection, key, "", value, sizearray(value), ProfileFile);
    ptr = strchr(value, '|');
    if (ptr != NULL && strlen(ptr + 1) < MAX_EXPR_LEN)
      strcpy(Expression[idx], ptr + 1);
    ColourIdx[idx] = (int)strtol(value, NULL, 10);
    if (ColourIdx[idx] <= 0 || ColourIdx[idx] > 15)
      ColourIdx[idx] = 1;
  }

  BufferSize = 0;
  BufferRemove = 0;

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


/* flt_Flags() is called when Termite starts up, and browses through all
 * filters to verify their class and settings.
 */
int FLTEXPORT flt_Flags(void)
{
  return 1; /* tell Termite that this is an RTF filter */
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
  int numbytes, codelen;
  int matchidx, matchoffs, matchstart, matchend, matchscanned, matchcount;
  LPSTR BufPtr, Ptr, Tail;
  char colourcode[10];

  /* see whether there is data in the buffer that should be stripped (handled
     from the previous call) */
  if (BufferRemove > 0) {
    BufPtr = txtbuf_Alloc(BufferSize);  /* just returns the current buffer (no resize) */
    assert(BufPtr != NULL);
    assert(BufferRemove <= BufferSize);
    if (BufferRemove < BufferSize)
      memmove(BufPtr, BufPtr + BufferRemove, BufferSize - BufferRemove);
    BufferSize -= BufferRemove;
    assert(BufferSize >= 0);
    BufferRemove = 0;
  } /* if */

  /* buffer a complete line */
  numbytes = BufferSize + *Size;
  BufPtr = txtbuf_Alloc(numbytes);
  if (BufPtr == NULL)
    return NULL;  /* this can also happen if both BufferSize & *Size are zero */

  matchcount = 0;
  if (*Size > 0) {
    memcpy(BufPtr + BufferSize, Text, *Size);
    BufferSize = numbytes;

    /* see whether we have at least one complete line in the buffer */
    Tail = NULL;
    Ptr = BufPtr;
    for ( ;; ) {
      while ((Ptr - BufPtr) < numbytes && *Ptr != '\r' && *Ptr != '\n')
        Ptr++;
      if ((Ptr - BufPtr) >= numbytes)
        break;
      while ((Ptr - BufPtr) < numbytes && (*Ptr == '\r' || *Ptr == '\n'))
        Ptr++;
      Tail = Ptr;
    } /* for */
    /* if no line, gobble all */
    if (Tail == NULL) {
      *Size = 0;
      return NULL;
    } /* if */
    /* if arrived here, there is at least one full line in the buffer (possibly more) */
    assert(Tail != NULL);
    BufferRemove = (int)(Tail - BufPtr);
    matchoffs = 0;
    for ( ;; ) {
      matchidx = match(BufPtr + matchoffs, BufferRemove - matchoffs,
                       &matchstart, &matchend, &matchscanned);
      if (matchidx < 0)
        break;
      matchcount++;
      wsprintf(colourcode, "\\cf%d ", ColourIdx[matchidx]);
      codelen = strlen(colourcode);
      #define CF0_LEN   5       /* length of "\cf0 " */
      BufferSize += codelen + CF0_LEN;
      if ((BufPtr = txtbuf_Alloc(BufferSize)) == NULL)
        return NULL;
      /* insert colour codes */
      Ptr = BufPtr + matchoffs + matchstart;
      memmove(Ptr + codelen, Ptr, BufferRemove - matchoffs - matchstart);
      memmove(Ptr, colourcode, codelen);
      Ptr = BufPtr + matchoffs + matchend + codelen;
      memmove(Ptr + CF0_LEN, Ptr, BufferRemove - matchoffs - matchend);
      memmove(Ptr, "\\cf0 ", CF0_LEN);
      matchoffs += matchscanned + codelen + CF0_LEN;
      BufferRemove += codelen + CF0_LEN;
    }
    *Size = BufferRemove;
  } else {
    /* special case, if *Size is zero on input, return the buffered data */
    assert(*Size == 0);
    BufferRemove = BufferSize;
    matchoffs = 0;
    for ( ;; ) {
      matchidx = match(BufPtr + matchoffs, BufferRemove - matchoffs,
                       &matchstart, &matchend, &matchscanned);
      if (matchidx < 0)
        break;
      matchcount++;
      wsprintf(colourcode, "\\cf%d ", ColourIdx[matchidx]);
      codelen = strlen(colourcode);
      #define CF0_LEN   5       /* length of "\cf0 " */
      BufferSize += codelen + CF0_LEN;
      if ((BufPtr = txtbuf_Alloc(BufferSize)) == NULL)
        return NULL;
      /* insert colour codes */
      Ptr = BufPtr + matchoffs + matchstart;
      memmove(Ptr + codelen, Ptr, BufferRemove - matchoffs - matchstart);
      memmove(Ptr, colourcode, codelen);
      Ptr = BufPtr + matchoffs + matchend + codelen;
      memmove(Ptr + CF0_LEN, Ptr, BufferRemove - matchoffs - matchend);
      memmove(Ptr, "\\cf0 ", CF0_LEN);
      matchoffs += matchscanned + codelen + CF0_LEN;
      BufferRemove += codelen + CF0_LEN;
    }
    *Size = BufferSize;
    BufferSize = 0;
    BufferRemove = 0;
  } /* if */

  return (matchcount > 0) ? BufPtr : NULL;  /* if no matches, no need to convert to RTF */
}


BOOL FLTEXPORT flt_Config(void)
{
  int result;

  /* pop up the dialog for configuration */
  result = DialogBox(hinstDLL, "FilterConfig", GetFocus(), (DLGPROC)FilterConfigDlg);
  if (result == IDOK) {
    /* save the new settings back to the INI file */
    int idx;
    char key[20], value[MAX_EXPR_LEN + 16];;
    for (idx = 0; idx < NUM_EXPRESSIONS; idx++) {
      wsprintf(key, strExprKey, idx + 1);
      wsprintf(value, "%d|%s", ColourIdx[idx], Expression[idx]);
      WritePrivateProfileString(strSection, key, value, ProfileFile);
    } /* for */
  } /* if */

  return (result == IDOK);
}

#pragma argsused
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  static HBRUSH hbrBtn;
  int idx, sel, len;
  char *ptr;

  switch (msg) {
  case WM_INITDIALOG:
    /* copy current settings into the controls */
    for (idx = 0; idx < NUM_EXPRESSIONS; idx++) {
      SetDlgItemText(hwnd, IDD_MATCH1 + idx, Expression[idx]);
      SendDlgItemMessage(hwnd, IDD_MATCH1 + idx, EM_LIMITTEXT, MAX_EXPR_LEN - 1, 0L);
    } /* for */
    hbrBtn = NULL;
    return TRUE;

  case WM_DESTROY:
    if (hbrBtn)
      DeleteObject(hbrBtn);
    return FALSE;

  case WM_COMMAND:
    switch (LOWORD(wParam)) {
    case IDCANCEL:
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDOK:
      /* copy edited fields back to the global variables */
      for (idx = 0; idx < NUM_EXPRESSIONS; idx++) {
        GetDlgItemText(hwnd, IDD_MATCH1 + idx, Expression[idx], MAX_EXPR_LEN);
        /* with the exception of "i)" at the beginning, insert a backslash
           before every '(' and ')' */
        ptr = Expression[idx];
        if (strncmp(ptr, "i)", 2) == 0)
          ptr += 2;
        while ((ptr = strpbrk(ptr, "()")) != NULL && strlen(Expression[idx]) < MAX_EXPR_LEN - 1) {
          /* first check whether there is a backslash already */
          if (ptr != Expression[idx] && *(ptr - 1) != '\\') {
            len = strlen(ptr);
            memmove(ptr + 1, ptr, strlen(ptr) + 1);
            *ptr = '\\';
            ptr += 2; /* skip both \ and the parenthesis */
          }
        }
      }
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDHELP:
      DialogBox(hinstDLL, "FilterInfo", hwnd, (DLGPROC)FilterInfoDlg);
      return TRUE;
    default:
      if (LOWORD(wParam) >= IDD_COLOUR1 && LOWORD(wParam) < IDD_COLOUR1 + NUM_EXPRESSIONS
          && HIWORD(wParam) == STN_CLICKED)
      {
        idx = LOWORD(wParam) - IDD_COLOUR1;
        sel = DialogBoxParam(hinstDLL, "ColourSelect", hwnd, (DLGPROC)ColourSelectDlg, LOWORD(wParam));
        if (sel > 0) {
          ColourIdx[idx] = sel;
          InvalidateRect((HWND)lParam, NULL, TRUE);
        } /* if */
        SetFocus((HWND)lParam);
      } /* if */
    } /* switch */
    break;

  case WM_CTLCOLORSTATIC:
    idx = (int)GetMenu((HWND)lParam) - IDD_COLOUR1;
    if (idx >= 0 && idx < NUM_EXPRESSIONS) {
      if (hbrBtn)
        DeleteObject(hbrBtn);
      hbrBtn = CreateSolidBrush(Colour[ColourIdx[idx]]);
      SetWindowLong(hwnd, DWL_MSGRESULT, (long)hbrBtn); /* appears not to be needed */
      return (BOOL)hbrBtn;
    }
    return FALSE;
  } /* switch */


  return FALSE;
}

#pragma argsused
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
static const
#include "highlight-help.c"

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

#pragma argsused
BOOL CALLBACK ColourSelectDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  static HBRUSH hbrBtn;
  static BOOL ColourSelected;
  int idx;
  HWND hwndParent, hwndCtrl;
  RECT rc;

  switch (msg) {
  case WM_INITDIALOG:
    /* find the control that this dialog must be attached to */
    hwndParent = GetParent(hwnd);
    assert(hwndParent != NULL);
    hwndCtrl = GetDlgItem(hwndParent, (int)lParam);
    assert(hwndCtrl != NULL);
    /* find the position of the control, position this window */
    GetWindowRect(hwndCtrl, &rc);
    SetWindowPos(hwnd, HWND_TOPMOST, rc.left - 1, rc.bottom, 0, 0,  SWP_NOSIZE);
    ColourSelected = FALSE;
    return TRUE;

  case WM_DESTROY:
    if (hbrBtn)
      DeleteObject(hbrBtn);
    return FALSE;

  case WM_COMMAND:
    if (LOWORD(wParam) >= IDD_COLOUR1 && LOWORD(wParam) <= IDD_COLOUR15) {
      ColourSelected = TRUE;
      EndDialog(hwnd, LOWORD(wParam) - IDD_COLOUR1 + 1);
      return TRUE;
    } else if (LOWORD(wParam) == IDCANCEL) {
      EndDialog(hwnd, 0);
    } /* if */
    return TRUE;

  case WM_NCACTIVATE:
    if (LOWORD(wParam) == WA_INACTIVE && !ColourSelected)
      EndDialog(hwnd, 0);
    return TRUE;

  case WM_CTLCOLORSTATIC:
    idx = (int)GetMenu((HWND)lParam) - IDD_COLOUR1 + 1;
    if (idx > 0 && idx <= 15) {
      if (hbrBtn)
        DeleteObject(hbrBtn);
      hbrBtn = CreateSolidBrush(Colour[idx]);
      SetWindowLong(hwnd, DWL_MSGRESULT, (long)hbrBtn); /* appears not to be needed */
      return (BOOL)hbrBtn;
    }
    return FALSE;
  } /* switch */

  return FALSE;
}

int match(const char *string, int length, int *start, int *end, int *scanned)
{
  struct slre_cap caps[2];
  char expr[MAX_EXPR_LEN+10]; /* for the parentheses around the expression and the (?i) option */
  char *ptr;
  int idx;

  for (idx = 0; idx < NUM_EXPRESSIONS; idx += 1) {
    if (strlen(Expression[idx]) == 0)
      continue;         /* an empty string matches nothing */
    if (strncmp(Expression[idx], "i)", 2) == 0) {
      strcpy(expr, "(?i)(");
      ptr = Expression[idx] + 2;
    } else {
      strcpy(expr, "(");
      ptr = Expression[idx];
    }
    strcat(expr, ptr);
    strcat(expr, ")");
    assert(scanned != NULL);
    *scanned = slre_match(expr, string, length, caps, 2);
    if (*scanned >= 0) {
      assert(start != NULL && end != NULL);
      *start = (int)(caps[0].ptr - string);
      *end = *start + caps[0].len;
      return idx;
    }
  }
  return -1;
}

