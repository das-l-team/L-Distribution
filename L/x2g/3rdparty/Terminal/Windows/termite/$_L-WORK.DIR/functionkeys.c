/*  Termite filter: Transmit user-defined text on a function key
 *
 *  Copyright (c) ITB CompuPhase, 2010-2012
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
#include <mmsystem.h>
#include "functionkeys.h"


#define FLTEXPORT __declspec(dllexport) __stdcall

#if !defined sizearray
  #define sizearray(a)  (sizeof(a) / sizeof((a)[0]))
#endif

    /* a few strings that are used in various locations */
const char strCaption[] = "FunctionKeys filter";
const char strSection[] = "FunctionKeys";
const char strKeyItem[] = "key%d";
const char strKeyItemRepeat[] = "key%d-repeat";


    /* forward declarations of a few functions */
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
static void strreplace(char *str, size_t max, const char *from, const char *to);
static int gcd(int a, int b);
static void CALLBACK TimerCallbackWindow(UINT idTimer,UINT msg,DWORD_PTR dwUser,
                                         DWORD_PTR dw1,DWORD_PTR dw2);

    /* constants */
#define MAX_FKEYS       12  /* support up to 12 function keys right-now */
#define MAX_TEXTLENGTH  256 /* max. length of macro text */
#define UM_POSTHOTKEY   (WM_APP + 3)  /* also defined in filter.h */

    /* this variable is declared in dllmain.c */
extern HINSTANCE hinstDLL;

    /* a few global variables for this particular filter */
static unsigned char *KeyDefs[MAX_FKEYS];
static DWORD KeyRepeat[MAX_FKEYS];
static DWORD KeyRepeatTimeout[MAX_FKEYS];
static char ProfileFile[_MAX_PATH];
static HWND hwndTermite;
static int TimerInterval;
static MMRESULT TimerID = 0;


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
  char str[MAX_TEXTLENGTH];
  char item[64];
  int idx;

  (void)Build;        /* this parameters is not used */

  hwndTermite = hwnd;

  /* read settings (from the same INI file as Termite uses) */
  strcpy(ProfileFile, ProfileName); /* save name of the INI file */
  for (idx = 0; idx < MAX_FKEYS; idx++) {
    wsprintf(item, strKeyItem, idx + 1);
    GetPrivateProfileString(strSection, item, "", str, sizearray(str), ProfileFile);
    strreplace(str, sizearray(str), "\\t", "\t");
    strreplace(str, sizearray(str), "\\r", "\r");
    strreplace(str, sizearray(str), "\\n", "\n");
    KeyDefs[idx] = strdup(str);
    wsprintf(item, strKeyItemRepeat, idx + 1);
    KeyRepeat[idx] = GetPrivateProfileInt(strSection, item, 0, ProfileFile);
  } /* for */

  /* see whether a timer must be set up */
  TimerInterval = 0;
  for (idx = 0; idx < MAX_FKEYS; idx++) {
    if (KeyRepeat[idx] > 0) {
      /* calculate the smallest common interval */
      if (TimerInterval == 0)
        TimerInterval = KeyRepeat[idx];
      else
        TimerInterval = gcd(TimerInterval, KeyRepeat[idx]);
    }
  }
  if (TimerInterval > 0) {
    timeBeginPeriod(1);
    TimerID = timeSetEvent(TimerInterval, 0, TimerCallbackWindow, 0, TIME_PERIODIC);
  }
  for (idx = 0; idx < MAX_FKEYS; idx++)
    KeyRepeatTimeout[idx] = 0;

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
  int idx;

  if (TimerID != 0) {
    timeKillEvent(TimerID);
    timeEndPeriod(1);
  }

  /* free macros */
  for (idx = 0; idx < MAX_FKEYS; idx++) {
    free(KeyDefs[idx]);
    KeyRepeatTimeout[idx] = 0;
  }
}


/* flt_HotKey() is called on a function key press.
 *
 * vKey         The virtual key of the function key.
 * Text         A pointer to a buffer where to store the data to be transmit.
 *              On entry, this string is empty, unless another filter has
 *              generated data for this function key as well.
 * Size         This parameter must hold the new size of the data block (on
 *              output).
 *
 * If flt_HotKey() does not produce output, it can return NULL or return
 * the original (usually empty) string.
 *
 * The output string is not necessarily zero-terminated; the filter must adjust
 * the length to the number of bytes it returns (parameter "Size").
 */
LPCSTR FLTEXPORT flt_HotKey(int vKey, LPCSTR Text, LPINT Size)
{
  int idx;

  /* find the entry */
  idx = vKey - VK_F1;
  if (idx < 0 || idx >= MAX_FKEYS)
    return NULL;        /* function key is out of range */

  /* check that we handle this key */
  if (KeyDefs[idx] == NULL || strlen(KeyDefs[idx]) == 0)
    return NULL;

  /* verify whether we are the first filter to handle this key */
  if (strlen(Text) > 0) {
    MessageBox(hwndTermite, "Duplicate definition for this function key", NULL, MB_OK);
    return NULL;
  } /* if */

  /* as soon as the key is pressed, flag it for auto-repeat (or turn it off) */
  if ((GetKeyState(VK_SHIFT) & 0x80000000) == 0)
    KeyRepeatTimeout[idx] = KeyRepeat[idx];
  else
    KeyRepeatTimeout[idx] = 0;

  *Size = strlen(KeyDefs[idx]);
  return KeyDefs[idx];
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
    char item[64];
    int idx;
    for (idx = 0; idx < MAX_FKEYS; idx++) {
      char str[MAX_TEXTLENGTH];
      wsprintf(item, strKeyItem, idx + 1);
      if (KeyDefs[idx] != NULL && strlen(KeyDefs[idx]) > 0) {
        assert(strlen(KeyDefs[idx]) < sizearray(str));
        strcpy(str, KeyDefs[idx]);
        strreplace(str, sizearray(str), "\t", "\\t");
        strreplace(str, sizearray(str), "\r", "\\r");
        strreplace(str, sizearray(str), "\n", "\\n");
        WritePrivateProfileString(strSection, item, str, ProfileFile);
      } else {
        WritePrivateProfileString(strSection, item, NULL, ProfileFile);
      } /* if */
      wsprintf(item, strKeyItemRepeat, idx + 1);
      if (KeyRepeat[idx] > 0) {
        wsprintf(str, "%d", KeyRepeat[idx]);
        WritePrivateProfileString(strSection, item, str, ProfileFile);
      } else {
        WritePrivateProfileString(strSection, item, NULL, ProfileFile);
      }
    } /* for */
  } /* if */

  return (result == IDOK);
}


#pragma argsused
BOOL CALLBACK FilterConfigDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  char str[MAX_TEXTLENGTH];
  int idx;

  switch (msg) {
  case WM_INITDIALOG:
    /* copy current settings into the controls */
    for (idx = 0; idx < MAX_FKEYS; idx++) {
      assert(strlen(KeyDefs[idx]) < sizearray(str));
      strcpy(str, KeyDefs[idx]);
      strreplace(str, sizearray(str), "\t", "\\t");
      strreplace(str, sizearray(str), "\r", "\\r");
      strreplace(str, sizearray(str), "\n", "\\n");
      SetDlgItemText(hwnd, EDIT_F1 + idx, str);
      SendDlgItemMessage(hwnd, EDIT_F1 + idx, EM_LIMITTEXT, MAX_TEXTLENGTH - 1, 0);
      if (KeyRepeat[idx] > 0) {
        CheckDlgButton(hwnd, CHK_REPEAT_F1 + idx, BST_CHECKED);
        SetDlgItemInt(hwnd, EDIT_REPEAT_F1 + idx, KeyRepeat[idx], FALSE);
      } else {
        EnableWindow(GetDlgItem(hwnd, EDIT_REPEAT_F1 + idx), FALSE);
      }
    } /* for */
    return TRUE;

  case WM_COMMAND:
    switch (LOWORD(wParam)) {
    case IDCANCEL:
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDOK:
      /* copy edited fields back to the global variable */
      for (idx = 0; idx < MAX_FKEYS; idx++) {
        GetDlgItemText(hwnd, EDIT_F1 + idx, str, sizearray(str));
        free(KeyDefs[idx]);
        strreplace(str, sizearray(str), "\\t", "\t");
        strreplace(str, sizearray(str), "\\r", "\r");
        strreplace(str, sizearray(str), "\\n", "\n");
        KeyDefs[idx] = strdup(str);
        if (IsDlgButtonChecked(hwnd, CHK_REPEAT_F1 + idx))
          KeyRepeat[idx] = GetDlgItemInt(hwnd, EDIT_REPEAT_F1 + idx, NULL, FALSE);
        else
          KeyRepeat[idx] = 0;
      } /* for */
      EndDialog(hwnd, LOWORD(wParam));
      return TRUE;
    case IDHELP:
      DialogBox(hinstDLL, "FilterInfo", hwnd, (DLGPROC)FilterInfoDlg);
      return TRUE;
    case CHK_REPEAT_F1:
    case CHK_REPEAT_F2:
    case CHK_REPEAT_F3:
    case CHK_REPEAT_F4:
    case CHK_REPEAT_F5:
    case CHK_REPEAT_F6:
    case CHK_REPEAT_F7:
    case CHK_REPEAT_F8:
    case CHK_REPEAT_F9:
    case CHK_REPEAT_F10:
    case CHK_REPEAT_F11:
    case CHK_REPEAT_F12:
      idx = LOWORD(wParam) - CHK_REPEAT_F1;
      EnableWindow(GetDlgItem(hwnd, EDIT_REPEAT_F1 + idx), IsDlgButtonChecked(hwnd, CHK_REPEAT_F1 + idx));
      return TRUE;
    } /* switch */
    break;
  } /* switch */

  return FALSE;
}

#pragma argsused
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
static const
#include "functionkeys-help.c"

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


static void strreplace(char *str, size_t max, const char *from, const char *to)
{
  char *ptr;
  int expand, copy;

  assert(str != NULL && from != NULL && to != NULL);
  copy = strlen(to);
  expand = copy - strlen(from);

  while ((ptr = strstr(str, from)) != NULL && strlen(str) + expand < max) {
    if (expand < 0)
      memmove(ptr, ptr - expand, strlen(ptr - expand) + 1);
    else
      memmove(ptr + expand, ptr, strlen(ptr) + 1);
    memmove(ptr, to, copy);
  } /* while */
}

/* The greatest common divisor of two values, using Euclides' algorithm */
static int gcd(int a, int b)
{
  while (a != b) {
    if (a > b)
      a = a - b;
    else
      b = b - a;
  }
  return a;
}

#pragma argsused
static void CALLBACK TimerCallbackWindow(UINT idTimer,UINT msg,DWORD_PTR dwUser,
                                         DWORD_PTR dw1,DWORD_PTR dw2)
{
  int idx;

  for (idx = 0; idx < MAX_FKEYS; idx++) {
    if (KeyRepeatTimeout[idx] > 0) {
      KeyRepeatTimeout[idx] -= TimerInterval;
      if (KeyRepeatTimeout[idx] == 0) {
        if (KeyDefs[idx] != NULL && strlen(KeyDefs[idx]) != 0)
          PostMessage(hwndTermite, UM_POSTHOTKEY, VK_F1 + idx, (long)KeyDefs[idx]);
        KeyRepeatTimeout[idx] = KeyRepeat[idx]; /* reload repeat interval */
      }
    }
  }
}
