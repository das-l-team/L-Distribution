/*  Simple routine for dynamically growing (text) buffer.
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
 *
 *  Version: $Id: textbuffer.c 4585 2011-10-18 15:29:53Z thiadmer $
 */

#include <assert.h>
#include <windows.h>
#include "textbuffer.h"

static unsigned char *Buffer = NULL;
static unsigned int BufferSize = 0;

LPSTR txtbuf_Alloc(DWORD RequiredSize)
{
  unsigned char *newbuffer;
  unsigned int newsize;

  assert(Buffer == NULL || BufferSize > 0);

  if (RequiredSize == 0)
    return NULL;

  if (RequiredSize <= BufferSize) {
    assert(Buffer != NULL);
    return Buffer;
  } /* if */

  /* find out the best new size to use */
  newsize = (BufferSize > 0) ? BufferSize : 512;
  while (newsize < RequiredSize)
    newsize *= 2;

  /* allocate new memory, copy the existing data and free old buffer */
  if ((newbuffer = malloc(newsize)) == NULL)
    return NULL;  /* failed to allocate a new block, keep the reference to the current buffer */
  if (Buffer != NULL) {
    assert(newsize > BufferSize);
    memcpy(newbuffer, Buffer, BufferSize);
    free(Buffer); /* free old buffer */
  } /* if */
  Buffer = newbuffer;
  BufferSize = newsize;

  return Buffer;
}

void txtbuf_Free(void)
{
  if (Buffer != NULL)
    free(Buffer);
  Buffer = NULL;
  BufferSize = 0;
}

unsigned txtbuf_GetSize(void)
{
  return BufferSize;
}
