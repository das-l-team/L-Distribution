/*  DLL support functions for Termite filters.
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

#include <assert.h>
#include <windows.h>

HINSTANCE hinstDLL;

/* Especially Watcom C/C++ does not like DLLs that do not have a LibMain()
 * set. Apparently, the start address is not set well, and some required
 * initializations are not done.
 */
BOOL WINAPI DllMain(HINSTANCE hinst, DWORD dwReason, LPVOID lpRes)
{
  (void)lpRes;
  switch (dwReason) {
  case DLL_PROCESS_ATTACH:
    hinstDLL=hinst;
    break;
  case DLL_PROCESS_DETACH:
    break;
  } /* switch */
  return TRUE;
}
