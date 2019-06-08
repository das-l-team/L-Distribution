/*  Termite filter: show status of control lines (RTS/CTS, DTR/DSR, RI)
 *
 *  Copyright (c) CompuPhase, 2009-2012
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
#include "statusleds.h"

#define FLTEXPORT __declspec(dllexport) __stdcall


    /* To create a window in Termites interface, the plugin must send the
     * message UM_PLUGINWINDOW to the Termite main window from its flt_Load()
     * function. That is, the plugin must have an flt_Load() function and it
     * must call "SendMessage(hwnd,UM_PLUGINWINDOW,nnn,0L);"
     * The wParam parameter ("nnn" in the above example) is the height of the
     * window (in pixels). The return value of the SendMessage() call is the
     * window handle. Typically, a plugin will subclass this window in order to
     * receive notifications for any controls that it creates in it.
     */
#define UM_PLUGINWINDOW (WM_APP + 1)

#define UM_COMMHANDLE   (WM_APP + 2)


    /* control identifiers for buttons and labels */
enum {
  ID_HELP = 100,
  ID_RTS,
  ID_DTR,
  ID_BREAK,
  ID_CTS,
  ID_DSR,
  ID_RI,
  ID_CD,
  ID_ERR,
  ID_LBL_RTS,
  ID_LBL_DTR,
  ID_LBL_CTS,
  ID_LBL_DSR,
  ID_LBL_RI,
  ID_LBL_CD,
  ID_LBL_ERR,
  ID_LBL_BREAK,
  ID_LBL_LOCAL,
  ID_LBL_REMOTE,
};


    /* this variable is declared in dllmain.c */
extern HINSTANCE hinstDLL;

    /* global variables */
static HWND hwndTermite;  /* handle of Termite's main window */
static HWND hwndPlugin;   /* handle of the sub-window that Termite creates for this plugin */
static HFONT hfontTiny, hfontNormal;
static HBITMAP hbmpOff, hbmpOn, hbmpHelp;
static WNDPROC lpfnOldWndProc;
static DWORD ModemStat;
static int BreakTimeout, ErrorTimeout;


    /* forward-declared function for the subclassed window */
LRESULT FAR PASCAL SubClassFunc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);


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
  (void)ProfileName;    /* these parameters are not used */
  (void)Build;

  hwndTermite = hwnd;
  hwndPlugin = (HWND)SendMessage(hwnd, UM_PLUGINWINDOW, 18, 0L);
  if (hwndPlugin) {
    /* create help button */
    CreateWindow("button", "HELP_BUTTON", WS_CHILD | WS_VISIBLE | BS_BITMAP | BS_PUSHBUTTON | BS_FLAT, 0, 0, 17, 17, hwndPlugin, (HMENU)ID_HELP, hinstDLL, NULL);

    /* create LED controls */
    CreateWindow("button", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | BS_BITMAP | BS_AUTOCHECKBOX | BS_PUSHLIKE | BS_FLAT, 72, 0, 16, 8, hwndPlugin, (HMENU)ID_RTS, hinstDLL, NULL);
    CreateWindow("button", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | BS_BITMAP | BS_AUTOCHECKBOX | BS_PUSHLIKE | BS_FLAT, 104, 0, 16, 8, hwndPlugin, (HMENU)ID_DTR, hinstDLL, NULL);
    CreateWindow("static", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | SS_BITMAP, 192, 0, 16, 8, hwndPlugin, (HMENU)ID_CTS, hinstDLL, NULL);
    CreateWindow("static", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | SS_BITMAP, 224, 0, 16, 8, hwndPlugin, (HMENU)ID_DSR, hinstDLL, NULL);
    CreateWindow("static", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | SS_BITMAP, 256, 0, 16, 8, hwndPlugin, (HMENU)ID_RI, hinstDLL, NULL);
    CreateWindow("static", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | SS_BITMAP, 288, 0, 16, 8, hwndPlugin, (HMENU)ID_CD, hinstDLL, NULL);
    CreateWindow("static", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | SS_BITMAP, 320, 0, 16, 8, hwndPlugin, (HMENU)ID_ERR, hinstDLL, NULL);
    CreateWindow("button", "LED_DKGREEN", WS_CHILD | WS_VISIBLE | BS_BITMAP | BS_CHECKBOX | BS_PUSHLIKE | BS_FLAT, 376, 0, 16, 8, hwndPlugin, (HMENU)ID_BREAK, hinstDLL, NULL);

    /* create label controls */
    CreateWindow("static", "RTS", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 72, 8, 24, 10, hwndPlugin, (HMENU)ID_LBL_RTS, hinstDLL, NULL);
    CreateWindow("static", "DTR", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 104, 8, 24, 10, hwndPlugin, (HMENU)ID_LBL_DTR, hinstDLL, NULL);
    CreateWindow("static", "CTS", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 192, 8, 24, 16, hwndPlugin, (HMENU)ID_LBL_CTS, hinstDLL, NULL);
    CreateWindow("static", "DSR", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 224, 8, 24, 16, hwndPlugin, (HMENU)ID_LBL_DSR, hinstDLL, NULL);
    CreateWindow("static", "RI", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 260, 8, 24, 16, hwndPlugin, (HMENU)ID_LBL_RI, hinstDLL, NULL);
    CreateWindow("static", "CD", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 291, 8, 24, 16, hwndPlugin, (HMENU)ID_LBL_CD, hinstDLL, NULL);
    CreateWindow("static", "ERR", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 320, 8, 24, 16, hwndPlugin, (HMENU)ID_LBL_ERR, hinstDLL, NULL);
    CreateWindow("static", "BREAK", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 372, 8, 28, 10, hwndPlugin, (HMENU)ID_LBL_BREAK, hinstDLL, NULL);
    CreateWindow("static", "Local", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 32, 0, 40, 16, hwndPlugin, (HMENU)ID_LBL_LOCAL, hinstDLL, NULL);
    CreateWindow("static", "Remote", WS_CHILD | WS_VISIBLE | SS_SIMPLE, 144, 0, 40, 16, hwndPlugin, (HMENU)ID_LBL_REMOTE, hinstDLL, NULL);

    /* set font for the labels */
    hfontTiny = CreateFont(10, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
                           ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                           DEFAULT_QUALITY, FF_DONTCARE | DEFAULT_PITCH,
                           "Arial");
    SendDlgItemMessage(hwndPlugin, ID_LBL_RTS, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_DTR, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_CTS, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_DSR, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_RI, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_CD, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_ERR, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_BREAK, WM_SETFONT, (WPARAM)hfontTiny, MAKELPARAM(TRUE,0));

    hfontNormal = CreateFont(14, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
                           ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                           DEFAULT_QUALITY, FF_DONTCARE | DEFAULT_PITCH,
                           "Arial");
    SendDlgItemMessage(hwndPlugin, ID_LBL_LOCAL, WM_SETFONT, (WPARAM)hfontNormal, MAKELPARAM(TRUE,0));
    SendDlgItemMessage(hwndPlugin, ID_LBL_REMOTE, WM_SETFONT, (WPARAM)hfontNormal, MAKELPARAM(TRUE,0));

    /* load the bitmaps for the LEDs */
    hbmpHelp = LoadImage(hinstDLL, "HELP_BUTTON", IMAGE_BITMAP, 16, 16, LR_DEFAULTSIZE);
    hbmpOff = LoadImage(hinstDLL, "LED_DKGREEN", IMAGE_BITMAP, 16, 8, LR_DEFAULTSIZE);
    hbmpOn = LoadImage(hinstDLL, "LED_LTGREEN", IMAGE_BITMAP, 16, 8, LR_DEFAULTSIZE);

    SendDlgItemMessage(hwndPlugin, ID_HELP, BM_SETIMAGE, 0, (LPARAM)hbmpHelp);
    SendDlgItemMessage(hwndPlugin, ID_RTS, BM_SETIMAGE, 0, (LPARAM)hbmpOff);
    SendDlgItemMessage(hwndPlugin, ID_DTR, BM_SETIMAGE, 0, (LPARAM)hbmpOff);
    SendDlgItemMessage(hwndPlugin, ID_BREAK, BM_SETIMAGE, 0, (LPARAM)hbmpOff);

    /* subclass the window, to get the notifications, and set a timer */
    lpfnOldWndProc = (WNDPROC)SetWindowLong(hwndPlugin, GWL_WNDPROC, (DWORD)SubClassFunc);
    SetTimer(hwndPlugin, 1, 100, NULL);

    /* if RTS/CTS or DTR/DSR hand-shaking is in effect, the RTS or DTR buttons
     * should be disabled (as the status should be handled by the operating
     * system)
     */
  } /* if */

  return TRUE;
}


/* flt_Unload() is called when Termite removes the filter.
 *
 * After calling this notification function, Termite will physically unload
 * the filter DLL.
 *
 * For filters that allocate dynamic memory or other resources, this is a good
 * moment to free these resources. A plugin window does not need to be removed,
 * as Termite will automatically remove any window that it created for the
 * plugin.
 */
void FLTEXPORT flt_Unload(void)
{
  /* remove subclass */
  SetWindowLong(hwndPlugin, GWL_WNDPROC, (DWORD)lpfnOldWndProc);
  /* delete resources */
  DeleteObject(hfontTiny);
  DeleteObject(hfontNormal);
  DeleteObject(hbmpOff);
  DeleteObject(hbmpOn);
}


/* flt_Receive() or flt_Transmit() is required for this plug-in. A plug-in will
 * not be loaded if it does not have either flt_Receive() or flt_Transmit().
 * Therefore, this plugin implements a dummy flt_Transmit().
 */
LPCSTR FLTEXPORT flt_Transmit(LPCSTR Text, LPINT Size)
{
  return NULL;
}


LRESULT FAR PASCAL SubClassFunc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  switch (msg) {
  case WM_COMMAND:
    if ((LOWORD(wParam) >= ID_HELP && LOWORD(wParam) <= ID_BREAK) && HIWORD(wParam) == BN_CLICKED) {
      HANDLE hcom = (HANDLE)SendMessage(hwndTermite, UM_COMMHANDLE, 0, 0L);
      if (hcom != INVALID_HANDLE_VALUE) {
        if (LOWORD(wParam) != ID_HELP) {
          if (IsDlgButtonChecked(hwnd, LOWORD(wParam)) == BST_CHECKED)
            SendDlgItemMessage(hwndPlugin, LOWORD(wParam), BM_SETIMAGE, 0, (LPARAM)hbmpOn);
          else
            SendDlgItemMessage(hwndPlugin, LOWORD(wParam), BM_SETIMAGE, 0, (LPARAM)hbmpOff);
        } /* if */
        switch (LOWORD(wParam)) {
        case ID_HELP:
          DialogBox(hinstDLL, "FilterInfo", hwnd, (DLGPROC)FilterInfoDlg);
          break;
        case ID_RTS:
          if (IsDlgButtonChecked(hwnd, ID_RTS) == BST_CHECKED)
            EscapeCommFunction(hcom, SETRTS);
          else
            EscapeCommFunction(hcom, CLRRTS);
          break;
        case ID_DTR:
          if (IsDlgButtonChecked(hwnd, ID_DTR) == BST_CHECKED)
            EscapeCommFunction(hcom, SETDTR);
          else
            EscapeCommFunction(hcom, CLRDTR);
          break;
        case ID_BREAK:
          SetCommBreak(hcom);
          Sleep(100); /* a 100 ms break is fairly standard */
          ClearCommBreak(hcom);
          break;
        } /* switch */
      } /* if */
      SetFocus(GetDlgItem(hwndTermite, 101));
    } /* if */
    break;

  case WM_TIMER: {
    HANDLE hcom;
    DWORD stat;
    hcom = (HANDLE)SendMessage(hwndTermite, UM_COMMHANDLE, 0, 0L);
    if (hcom == INVALID_HANDLE_VALUE || !GetCommModemStatus(hcom, &stat))
      stat = 0;
    if (stat != ModemStat) {
      ModemStat = stat;
      SendDlgItemMessage(hwndPlugin, ID_CTS, STM_SETIMAGE, IMAGE_BITMAP, (LPARAM)((stat & MS_CTS_ON) ? hbmpOn : hbmpOff));
      SendDlgItemMessage(hwndPlugin, ID_DSR, STM_SETIMAGE, IMAGE_BITMAP, (LPARAM)((stat & MS_DSR_ON) ? hbmpOn : hbmpOff));
      SendDlgItemMessage(hwndPlugin, ID_RI, STM_SETIMAGE, IMAGE_BITMAP, (LPARAM)((stat & MS_RING_ON) ? hbmpOn : hbmpOff));
      SendDlgItemMessage(hwndPlugin, ID_CD, STM_SETIMAGE, IMAGE_BITMAP, (LPARAM)((stat & MS_RLSD_ON) ? hbmpOn : hbmpOff));
    } /* if */
    if (hcom == INVALID_HANDLE_VALUE || !ClearCommError(hcom, &stat, NULL))
      stat = 0;
    if ((stat & CE_BREAK) != 0) {
      SendDlgItemMessage(hwndPlugin, ID_BREAK, BM_SETIMAGE, 0, (LPARAM)hbmpOn);
      BreakTimeout = 5;
    } else if (BreakTimeout > 0) {
      if (--BreakTimeout == 0)
        SendDlgItemMessage(hwndPlugin, ID_BREAK, BM_SETIMAGE, 0, (LPARAM)hbmpOff);
    } /* if */
    if ((stat & ~CE_BREAK) != 0) {
      SendDlgItemMessage(hwndPlugin, ID_ERR, STM_SETIMAGE, 0, (LPARAM)hbmpOn);
      ErrorTimeout = 5;
    } else if (ErrorTimeout > 0) {
      if (--ErrorTimeout == 0)
        SendDlgItemMessage(hwndPlugin, ID_ERR, STM_SETIMAGE, 0, (LPARAM)hbmpOff);
    } /* if */
    break;
  } /* case */

  default:
    return CallWindowProc(lpfnOldWndProc, hwnd, msg, wParam, lParam);
  } /* switch */

  return 0L;
}

#pragma argsused
BOOL CALLBACK FilterInfoDlg(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
static const
#include "statusleds-help.c"

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
    break;
  } /* switch */

  return FALSE;
}
