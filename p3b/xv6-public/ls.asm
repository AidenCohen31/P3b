
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   8:	83 ec 0c             	sub    $0xc,%esp
   b:	53                   	push   %ebx
   c:	e8 1f 03 00 00       	call   330 <strlen>
  11:	01 d8                	add    %ebx,%eax
  13:	83 c4 10             	add    $0x10,%esp
  16:	eb 03                	jmp    1b <fmtname+0x1b>
  18:	83 e8 01             	sub    $0x1,%eax
  1b:	39 d8                	cmp    %ebx,%eax
  1d:	72 05                	jb     24 <fmtname+0x24>
  1f:	80 38 2f             	cmpb   $0x2f,(%eax)
  22:	75 f4                	jne    18 <fmtname+0x18>
    ;
  p++;
  24:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  27:	83 ec 0c             	sub    $0xc,%esp
  2a:	53                   	push   %ebx
  2b:	e8 00 03 00 00       	call   330 <strlen>
  30:	83 c4 10             	add    $0x10,%esp
  33:	83 f8 0d             	cmp    $0xd,%eax
  36:	76 09                	jbe    41 <fmtname+0x41>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  38:	89 d8                	mov    %ebx,%eax
  3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  3d:	5b                   	pop    %ebx
  3e:	5e                   	pop    %esi
  3f:	5d                   	pop    %ebp
  40:	c3                   	ret    
  memmove(buf, p, strlen(p));
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	53                   	push   %ebx
  45:	e8 e6 02 00 00       	call   330 <strlen>
  4a:	83 c4 0c             	add    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	53                   	push   %ebx
  4f:	68 3c 0c 00 00       	push   $0xc3c
  54:	e8 f6 03 00 00       	call   44f <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  59:	89 1c 24             	mov    %ebx,(%esp)
  5c:	e8 cf 02 00 00       	call   330 <strlen>
  61:	89 c6                	mov    %eax,%esi
  63:	89 1c 24             	mov    %ebx,(%esp)
  66:	e8 c5 02 00 00       	call   330 <strlen>
  6b:	83 c4 0c             	add    $0xc,%esp
  6e:	ba 0e 00 00 00       	mov    $0xe,%edx
  73:	29 f2                	sub    %esi,%edx
  75:	52                   	push   %edx
  76:	6a 20                	push   $0x20
  78:	05 3c 0c 00 00       	add    $0xc3c,%eax
  7d:	50                   	push   %eax
  7e:	e8 c5 02 00 00       	call   348 <memset>
  return buf;
  83:	83 c4 10             	add    $0x10,%esp
  86:	bb 3c 0c 00 00       	mov    $0xc3c,%ebx
  8b:	eb ab                	jmp    38 <fmtname+0x38>

0000008d <ls>:

void
ls(char *path)
{
  8d:	55                   	push   %ebp
  8e:	89 e5                	mov    %esp,%ebp
  90:	57                   	push   %edi
  91:	56                   	push   %esi
  92:	53                   	push   %ebx
  93:	81 ec 54 02 00 00    	sub    $0x254,%esp
  99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  9c:	6a 00                	push   $0x0
  9e:	53                   	push   %ebx
  9f:	e8 1f 04 00 00       	call   4c3 <open>
  a4:	83 c4 10             	add    $0x10,%esp
  a7:	85 c0                	test   %eax,%eax
  a9:	0f 88 8c 00 00 00    	js     13b <ls+0xae>
  af:	89 c7                	mov    %eax,%edi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  b1:	83 ec 08             	sub    $0x8,%esp
  b4:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
  ba:	50                   	push   %eax
  bb:	57                   	push   %edi
  bc:	e8 1a 04 00 00       	call   4db <fstat>
  c1:	83 c4 10             	add    $0x10,%esp
  c4:	85 c0                	test   %eax,%eax
  c6:	0f 88 84 00 00 00    	js     150 <ls+0xc3>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  cc:	0f b7 85 c4 fd ff ff 	movzwl -0x23c(%ebp),%eax
  d3:	0f bf f0             	movswl %ax,%esi
  d6:	66 83 f8 01          	cmp    $0x1,%ax
  da:	0f 84 8d 00 00 00    	je     16d <ls+0xe0>
  e0:	66 83 f8 02          	cmp    $0x2,%ax
  e4:	75 41                	jne    127 <ls+0x9a>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
  e6:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
  ec:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
  f2:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
  f8:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
  fe:	83 ec 0c             	sub    $0xc,%esp
 101:	53                   	push   %ebx
 102:	e8 f9 fe ff ff       	call   0 <fmtname>
 107:	83 c4 08             	add    $0x8,%esp
 10a:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 110:	ff b5 b0 fd ff ff    	push   -0x250(%ebp)
 116:	56                   	push   %esi
 117:	50                   	push   %eax
 118:	68 b0 08 00 00       	push   $0x8b0
 11d:	6a 01                	push   $0x1
 11f:	e8 b4 04 00 00       	call   5d8 <printf>
    break;
 124:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 127:	83 ec 0c             	sub    $0xc,%esp
 12a:	57                   	push   %edi
 12b:	e8 7b 03 00 00       	call   4ab <close>
 130:	83 c4 10             	add    $0x10,%esp
}
 133:	8d 65 f4             	lea    -0xc(%ebp),%esp
 136:	5b                   	pop    %ebx
 137:	5e                   	pop    %esi
 138:	5f                   	pop    %edi
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    
    printf(2, "ls: cannot open %s\n", path);
 13b:	83 ec 04             	sub    $0x4,%esp
 13e:	53                   	push   %ebx
 13f:	68 88 08 00 00       	push   $0x888
 144:	6a 02                	push   $0x2
 146:	e8 8d 04 00 00       	call   5d8 <printf>
    return;
 14b:	83 c4 10             	add    $0x10,%esp
 14e:	eb e3                	jmp    133 <ls+0xa6>
    printf(2, "ls: cannot stat %s\n", path);
 150:	83 ec 04             	sub    $0x4,%esp
 153:	53                   	push   %ebx
 154:	68 9c 08 00 00       	push   $0x89c
 159:	6a 02                	push   $0x2
 15b:	e8 78 04 00 00       	call   5d8 <printf>
    close(fd);
 160:	89 3c 24             	mov    %edi,(%esp)
 163:	e8 43 03 00 00       	call   4ab <close>
    return;
 168:	83 c4 10             	add    $0x10,%esp
 16b:	eb c6                	jmp    133 <ls+0xa6>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 16d:	83 ec 0c             	sub    $0xc,%esp
 170:	53                   	push   %ebx
 171:	e8 ba 01 00 00       	call   330 <strlen>
 176:	83 c0 10             	add    $0x10,%eax
 179:	83 c4 10             	add    $0x10,%esp
 17c:	3d 00 02 00 00       	cmp    $0x200,%eax
 181:	76 14                	jbe    197 <ls+0x10a>
      printf(1, "ls: path too long\n");
 183:	83 ec 08             	sub    $0x8,%esp
 186:	68 bd 08 00 00       	push   $0x8bd
 18b:	6a 01                	push   $0x1
 18d:	e8 46 04 00 00       	call   5d8 <printf>
      break;
 192:	83 c4 10             	add    $0x10,%esp
 195:	eb 90                	jmp    127 <ls+0x9a>
    strcpy(buf, path);
 197:	83 ec 08             	sub    $0x8,%esp
 19a:	53                   	push   %ebx
 19b:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
 1a1:	56                   	push   %esi
 1a2:	e8 3d 01 00 00       	call   2e4 <strcpy>
    p = buf+strlen(buf);
 1a7:	89 34 24             	mov    %esi,(%esp)
 1aa:	e8 81 01 00 00       	call   330 <strlen>
 1af:	01 c6                	add    %eax,%esi
    *p++ = '/';
 1b1:	8d 46 01             	lea    0x1(%esi),%eax
 1b4:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 1ba:	c6 06 2f             	movb   $0x2f,(%esi)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	eb 19                	jmp    1db <ls+0x14e>
        printf(1, "ls: cannot stat %s\n", buf);
 1c2:	83 ec 04             	sub    $0x4,%esp
 1c5:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1cb:	50                   	push   %eax
 1cc:	68 9c 08 00 00       	push   $0x89c
 1d1:	6a 01                	push   $0x1
 1d3:	e8 00 04 00 00       	call   5d8 <printf>
        continue;
 1d8:	83 c4 10             	add    $0x10,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1db:	83 ec 04             	sub    $0x4,%esp
 1de:	6a 10                	push   $0x10
 1e0:	8d 85 d8 fd ff ff    	lea    -0x228(%ebp),%eax
 1e6:	50                   	push   %eax
 1e7:	57                   	push   %edi
 1e8:	e8 ae 02 00 00       	call   49b <read>
 1ed:	83 c4 10             	add    $0x10,%esp
 1f0:	83 f8 10             	cmp    $0x10,%eax
 1f3:	0f 85 2e ff ff ff    	jne    127 <ls+0x9a>
      if(de.inum == 0)
 1f9:	66 83 bd d8 fd ff ff 	cmpw   $0x0,-0x228(%ebp)
 200:	00 
 201:	74 d8                	je     1db <ls+0x14e>
      memmove(p, de.name, DIRSIZ);
 203:	83 ec 04             	sub    $0x4,%esp
 206:	6a 0e                	push   $0xe
 208:	8d 85 da fd ff ff    	lea    -0x226(%ebp),%eax
 20e:	50                   	push   %eax
 20f:	ff b5 ac fd ff ff    	push   -0x254(%ebp)
 215:	e8 35 02 00 00       	call   44f <memmove>
      p[DIRSIZ] = 0;
 21a:	c6 46 0f 00          	movb   $0x0,0xf(%esi)
      if(stat(buf, &st) < 0){
 21e:	83 c4 08             	add    $0x8,%esp
 221:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 227:	50                   	push   %eax
 228:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 22e:	50                   	push   %eax
 22f:	e8 a7 01 00 00       	call   3db <stat>
 234:	83 c4 10             	add    $0x10,%esp
 237:	85 c0                	test   %eax,%eax
 239:	78 87                	js     1c2 <ls+0x135>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 23b:	8b 9d d4 fd ff ff    	mov    -0x22c(%ebp),%ebx
 241:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
 247:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 24d:	0f b7 8d c4 fd ff ff 	movzwl -0x23c(%ebp),%ecx
 254:	66 89 8d b0 fd ff ff 	mov    %cx,-0x250(%ebp)
 25b:	83 ec 0c             	sub    $0xc,%esp
 25e:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 264:	50                   	push   %eax
 265:	e8 96 fd ff ff       	call   0 <fmtname>
 26a:	89 c2                	mov    %eax,%edx
 26c:	83 c4 08             	add    $0x8,%esp
 26f:	53                   	push   %ebx
 270:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 276:	0f bf 85 b0 fd ff ff 	movswl -0x250(%ebp),%eax
 27d:	50                   	push   %eax
 27e:	52                   	push   %edx
 27f:	68 b0 08 00 00       	push   $0x8b0
 284:	6a 01                	push   $0x1
 286:	e8 4d 03 00 00       	call   5d8 <printf>
 28b:	83 c4 20             	add    $0x20,%esp
 28e:	e9 48 ff ff ff       	jmp    1db <ls+0x14e>

00000293 <main>:

int
main(int argc, char *argv[])
{
 293:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 297:	83 e4 f0             	and    $0xfffffff0,%esp
 29a:	ff 71 fc             	push   -0x4(%ecx)
 29d:	55                   	push   %ebp
 29e:	89 e5                	mov    %esp,%ebp
 2a0:	57                   	push   %edi
 2a1:	56                   	push   %esi
 2a2:	53                   	push   %ebx
 2a3:	51                   	push   %ecx
 2a4:	83 ec 08             	sub    $0x8,%esp
 2a7:	8b 31                	mov    (%ecx),%esi
 2a9:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
 2ac:	83 fe 01             	cmp    $0x1,%esi
 2af:	7e 07                	jle    2b8 <main+0x25>
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 2b1:	bb 01 00 00 00       	mov    $0x1,%ebx
 2b6:	eb 23                	jmp    2db <main+0x48>
    ls(".");
 2b8:	83 ec 0c             	sub    $0xc,%esp
 2bb:	68 d0 08 00 00       	push   $0x8d0
 2c0:	e8 c8 fd ff ff       	call   8d <ls>
    exit();
 2c5:	e8 b9 01 00 00       	call   483 <exit>
    ls(argv[i]);
 2ca:	83 ec 0c             	sub    $0xc,%esp
 2cd:	ff 34 9f             	push   (%edi,%ebx,4)
 2d0:	e8 b8 fd ff ff       	call   8d <ls>
  for(i=1; i<argc; i++)
 2d5:	83 c3 01             	add    $0x1,%ebx
 2d8:	83 c4 10             	add    $0x10,%esp
 2db:	39 f3                	cmp    %esi,%ebx
 2dd:	7c eb                	jl     2ca <main+0x37>
  exit();
 2df:	e8 9f 01 00 00       	call   483 <exit>

000002e4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	56                   	push   %esi
 2e8:	53                   	push   %ebx
 2e9:	8b 75 08             	mov    0x8(%ebp),%esi
 2ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ef:	89 f0                	mov    %esi,%eax
 2f1:	89 d1                	mov    %edx,%ecx
 2f3:	83 c2 01             	add    $0x1,%edx
 2f6:	89 c3                	mov    %eax,%ebx
 2f8:	83 c0 01             	add    $0x1,%eax
 2fb:	0f b6 09             	movzbl (%ecx),%ecx
 2fe:	88 0b                	mov    %cl,(%ebx)
 300:	84 c9                	test   %cl,%cl
 302:	75 ed                	jne    2f1 <strcpy+0xd>
    ;
  return os;
}
 304:	89 f0                	mov    %esi,%eax
 306:	5b                   	pop    %ebx
 307:	5e                   	pop    %esi
 308:	5d                   	pop    %ebp
 309:	c3                   	ret    

0000030a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 30a:	55                   	push   %ebp
 30b:	89 e5                	mov    %esp,%ebp
 30d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 310:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 313:	eb 06                	jmp    31b <strcmp+0x11>
    p++, q++;
 315:	83 c1 01             	add    $0x1,%ecx
 318:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 31b:	0f b6 01             	movzbl (%ecx),%eax
 31e:	84 c0                	test   %al,%al
 320:	74 04                	je     326 <strcmp+0x1c>
 322:	3a 02                	cmp    (%edx),%al
 324:	74 ef                	je     315 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 326:	0f b6 c0             	movzbl %al,%eax
 329:	0f b6 12             	movzbl (%edx),%edx
 32c:	29 d0                	sub    %edx,%eax
}
 32e:	5d                   	pop    %ebp
 32f:	c3                   	ret    

00000330 <strlen>:

uint
strlen(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 336:	b8 00 00 00 00       	mov    $0x0,%eax
 33b:	eb 03                	jmp    340 <strlen+0x10>
 33d:	83 c0 01             	add    $0x1,%eax
 340:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 344:	75 f7                	jne    33d <strlen+0xd>
    ;
  return n;
}
 346:	5d                   	pop    %ebp
 347:	c3                   	ret    

00000348 <memset>:

void*
memset(void *dst, int c, uint n)
{
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	57                   	push   %edi
 34c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 34f:	89 d7                	mov    %edx,%edi
 351:	8b 4d 10             	mov    0x10(%ebp),%ecx
 354:	8b 45 0c             	mov    0xc(%ebp),%eax
 357:	fc                   	cld    
 358:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 35a:	89 d0                	mov    %edx,%eax
 35c:	8b 7d fc             	mov    -0x4(%ebp),%edi
 35f:	c9                   	leave  
 360:	c3                   	ret    

00000361 <strchr>:

char*
strchr(const char *s, char c)
{
 361:	55                   	push   %ebp
 362:	89 e5                	mov    %esp,%ebp
 364:	8b 45 08             	mov    0x8(%ebp),%eax
 367:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 36b:	eb 03                	jmp    370 <strchr+0xf>
 36d:	83 c0 01             	add    $0x1,%eax
 370:	0f b6 10             	movzbl (%eax),%edx
 373:	84 d2                	test   %dl,%dl
 375:	74 06                	je     37d <strchr+0x1c>
    if(*s == c)
 377:	38 ca                	cmp    %cl,%dl
 379:	75 f2                	jne    36d <strchr+0xc>
 37b:	eb 05                	jmp    382 <strchr+0x21>
      return (char*)s;
  return 0;
 37d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 382:	5d                   	pop    %ebp
 383:	c3                   	ret    

00000384 <gets>:

char*
gets(char *buf, int max)
{
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	57                   	push   %edi
 388:	56                   	push   %esi
 389:	53                   	push   %ebx
 38a:	83 ec 1c             	sub    $0x1c,%esp
 38d:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 390:	bb 00 00 00 00       	mov    $0x0,%ebx
 395:	89 de                	mov    %ebx,%esi
 397:	83 c3 01             	add    $0x1,%ebx
 39a:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 39d:	7d 2e                	jge    3cd <gets+0x49>
    cc = read(0, &c, 1);
 39f:	83 ec 04             	sub    $0x4,%esp
 3a2:	6a 01                	push   $0x1
 3a4:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3a7:	50                   	push   %eax
 3a8:	6a 00                	push   $0x0
 3aa:	e8 ec 00 00 00       	call   49b <read>
    if(cc < 1)
 3af:	83 c4 10             	add    $0x10,%esp
 3b2:	85 c0                	test   %eax,%eax
 3b4:	7e 17                	jle    3cd <gets+0x49>
      break;
    buf[i++] = c;
 3b6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3ba:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 3bd:	3c 0a                	cmp    $0xa,%al
 3bf:	0f 94 c2             	sete   %dl
 3c2:	3c 0d                	cmp    $0xd,%al
 3c4:	0f 94 c0             	sete   %al
 3c7:	08 c2                	or     %al,%dl
 3c9:	74 ca                	je     395 <gets+0x11>
    buf[i++] = c;
 3cb:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3cd:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3d1:	89 f8                	mov    %edi,%eax
 3d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    

000003db <stat>:

int
stat(const char *n, struct stat *st)
{
 3db:	55                   	push   %ebp
 3dc:	89 e5                	mov    %esp,%ebp
 3de:	56                   	push   %esi
 3df:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e0:	83 ec 08             	sub    $0x8,%esp
 3e3:	6a 00                	push   $0x0
 3e5:	ff 75 08             	push   0x8(%ebp)
 3e8:	e8 d6 00 00 00       	call   4c3 <open>
  if(fd < 0)
 3ed:	83 c4 10             	add    $0x10,%esp
 3f0:	85 c0                	test   %eax,%eax
 3f2:	78 24                	js     418 <stat+0x3d>
 3f4:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 3f6:	83 ec 08             	sub    $0x8,%esp
 3f9:	ff 75 0c             	push   0xc(%ebp)
 3fc:	50                   	push   %eax
 3fd:	e8 d9 00 00 00       	call   4db <fstat>
 402:	89 c6                	mov    %eax,%esi
  close(fd);
 404:	89 1c 24             	mov    %ebx,(%esp)
 407:	e8 9f 00 00 00       	call   4ab <close>
  return r;
 40c:	83 c4 10             	add    $0x10,%esp
}
 40f:	89 f0                	mov    %esi,%eax
 411:	8d 65 f8             	lea    -0x8(%ebp),%esp
 414:	5b                   	pop    %ebx
 415:	5e                   	pop    %esi
 416:	5d                   	pop    %ebp
 417:	c3                   	ret    
    return -1;
 418:	be ff ff ff ff       	mov    $0xffffffff,%esi
 41d:	eb f0                	jmp    40f <stat+0x34>

0000041f <atoi>:

int
atoi(const char *s)
{
 41f:	55                   	push   %ebp
 420:	89 e5                	mov    %esp,%ebp
 422:	53                   	push   %ebx
 423:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 426:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 42b:	eb 10                	jmp    43d <atoi+0x1e>
    n = n*10 + *s++ - '0';
 42d:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 430:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 433:	83 c1 01             	add    $0x1,%ecx
 436:	0f be c0             	movsbl %al,%eax
 439:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
 43d:	0f b6 01             	movzbl (%ecx),%eax
 440:	8d 58 d0             	lea    -0x30(%eax),%ebx
 443:	80 fb 09             	cmp    $0x9,%bl
 446:	76 e5                	jbe    42d <atoi+0xe>
  return n;
}
 448:	89 d0                	mov    %edx,%eax
 44a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44d:	c9                   	leave  
 44e:	c3                   	ret    

0000044f <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 44f:	55                   	push   %ebp
 450:	89 e5                	mov    %esp,%ebp
 452:	56                   	push   %esi
 453:	53                   	push   %ebx
 454:	8b 75 08             	mov    0x8(%ebp),%esi
 457:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 45a:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 45d:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 45f:	eb 0d                	jmp    46e <memmove+0x1f>
    *dst++ = *src++;
 461:	0f b6 01             	movzbl (%ecx),%eax
 464:	88 02                	mov    %al,(%edx)
 466:	8d 49 01             	lea    0x1(%ecx),%ecx
 469:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 46c:	89 d8                	mov    %ebx,%eax
 46e:	8d 58 ff             	lea    -0x1(%eax),%ebx
 471:	85 c0                	test   %eax,%eax
 473:	7f ec                	jg     461 <memmove+0x12>
  return vdst;
}
 475:	89 f0                	mov    %esi,%eax
 477:	5b                   	pop    %ebx
 478:	5e                   	pop    %esi
 479:	5d                   	pop    %ebp
 47a:	c3                   	ret    

0000047b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 47b:	b8 01 00 00 00       	mov    $0x1,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <exit>:
SYSCALL(exit)
 483:	b8 02 00 00 00       	mov    $0x2,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <wait>:
SYSCALL(wait)
 48b:	b8 03 00 00 00       	mov    $0x3,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <pipe>:
SYSCALL(pipe)
 493:	b8 04 00 00 00       	mov    $0x4,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <read>:
SYSCALL(read)
 49b:	b8 05 00 00 00       	mov    $0x5,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <write>:
SYSCALL(write)
 4a3:	b8 10 00 00 00       	mov    $0x10,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <close>:
SYSCALL(close)
 4ab:	b8 15 00 00 00       	mov    $0x15,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <kill>:
SYSCALL(kill)
 4b3:	b8 06 00 00 00       	mov    $0x6,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <exec>:
SYSCALL(exec)
 4bb:	b8 07 00 00 00       	mov    $0x7,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <open>:
SYSCALL(open)
 4c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <mknod>:
SYSCALL(mknod)
 4cb:	b8 11 00 00 00       	mov    $0x11,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <unlink>:
SYSCALL(unlink)
 4d3:	b8 12 00 00 00       	mov    $0x12,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <fstat>:
SYSCALL(fstat)
 4db:	b8 08 00 00 00       	mov    $0x8,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <link>:
SYSCALL(link)
 4e3:	b8 13 00 00 00       	mov    $0x13,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <mkdir>:
SYSCALL(mkdir)
 4eb:	b8 14 00 00 00       	mov    $0x14,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <chdir>:
SYSCALL(chdir)
 4f3:	b8 09 00 00 00       	mov    $0x9,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <dup>:
SYSCALL(dup)
 4fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <getpid>:
SYSCALL(getpid)
 503:	b8 0b 00 00 00       	mov    $0xb,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <sbrk>:
SYSCALL(sbrk)
 50b:	b8 0c 00 00 00       	mov    $0xc,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <sleep>:
SYSCALL(sleep)
 513:	b8 0d 00 00 00       	mov    $0xd,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <uptime>:
SYSCALL(uptime)
 51b:	b8 0e 00 00 00       	mov    $0xe,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <clone>:
SYSCALL(clone)
 523:	b8 16 00 00 00       	mov    $0x16,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <join>:
SYSCALL(join)
 52b:	b8 17 00 00 00       	mov    $0x17,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 533:	55                   	push   %ebp
 534:	89 e5                	mov    %esp,%ebp
 536:	83 ec 1c             	sub    $0x1c,%esp
 539:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 53c:	6a 01                	push   $0x1
 53e:	8d 55 f4             	lea    -0xc(%ebp),%edx
 541:	52                   	push   %edx
 542:	50                   	push   %eax
 543:	e8 5b ff ff ff       	call   4a3 <write>
}
 548:	83 c4 10             	add    $0x10,%esp
 54b:	c9                   	leave  
 54c:	c3                   	ret    

0000054d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 54d:	55                   	push   %ebp
 54e:	89 e5                	mov    %esp,%ebp
 550:	57                   	push   %edi
 551:	56                   	push   %esi
 552:	53                   	push   %ebx
 553:	83 ec 2c             	sub    $0x2c,%esp
 556:	89 45 d0             	mov    %eax,-0x30(%ebp)
 559:	89 d0                	mov    %edx,%eax
 55b:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 55d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 561:	0f 95 c1             	setne  %cl
 564:	c1 ea 1f             	shr    $0x1f,%edx
 567:	84 d1                	test   %dl,%cl
 569:	74 44                	je     5af <printint+0x62>
    neg = 1;
    x = -xx;
 56b:	f7 d8                	neg    %eax
 56d:	89 c1                	mov    %eax,%ecx
    neg = 1;
 56f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 576:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 57b:	89 c8                	mov    %ecx,%eax
 57d:	ba 00 00 00 00       	mov    $0x0,%edx
 582:	f7 f6                	div    %esi
 584:	89 df                	mov    %ebx,%edi
 586:	83 c3 01             	add    $0x1,%ebx
 589:	0f b6 92 34 09 00 00 	movzbl 0x934(%edx),%edx
 590:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 594:	89 ca                	mov    %ecx,%edx
 596:	89 c1                	mov    %eax,%ecx
 598:	39 d6                	cmp    %edx,%esi
 59a:	76 df                	jbe    57b <printint+0x2e>
  if(neg)
 59c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 5a0:	74 31                	je     5d3 <printint+0x86>
    buf[i++] = '-';
 5a2:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 5a7:	8d 5f 02             	lea    0x2(%edi),%ebx
 5aa:	8b 75 d0             	mov    -0x30(%ebp),%esi
 5ad:	eb 17                	jmp    5c6 <printint+0x79>
    x = xx;
 5af:	89 c1                	mov    %eax,%ecx
  neg = 0;
 5b1:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 5b8:	eb bc                	jmp    576 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
 5ba:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 5bf:	89 f0                	mov    %esi,%eax
 5c1:	e8 6d ff ff ff       	call   533 <putc>
  while(--i >= 0)
 5c6:	83 eb 01             	sub    $0x1,%ebx
 5c9:	79 ef                	jns    5ba <printint+0x6d>
}
 5cb:	83 c4 2c             	add    $0x2c,%esp
 5ce:	5b                   	pop    %ebx
 5cf:	5e                   	pop    %esi
 5d0:	5f                   	pop    %edi
 5d1:	5d                   	pop    %ebp
 5d2:	c3                   	ret    
 5d3:	8b 75 d0             	mov    -0x30(%ebp),%esi
 5d6:	eb ee                	jmp    5c6 <printint+0x79>

000005d8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5d8:	55                   	push   %ebp
 5d9:	89 e5                	mov    %esp,%ebp
 5db:	57                   	push   %edi
 5dc:	56                   	push   %esi
 5dd:	53                   	push   %ebx
 5de:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5e1:	8d 45 10             	lea    0x10(%ebp),%eax
 5e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 5e7:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 5ec:	bb 00 00 00 00       	mov    $0x0,%ebx
 5f1:	eb 14                	jmp    607 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5f3:	89 fa                	mov    %edi,%edx
 5f5:	8b 45 08             	mov    0x8(%ebp),%eax
 5f8:	e8 36 ff ff ff       	call   533 <putc>
 5fd:	eb 05                	jmp    604 <printf+0x2c>
      }
    } else if(state == '%'){
 5ff:	83 fe 25             	cmp    $0x25,%esi
 602:	74 25                	je     629 <printf+0x51>
  for(i = 0; fmt[i]; i++){
 604:	83 c3 01             	add    $0x1,%ebx
 607:	8b 45 0c             	mov    0xc(%ebp),%eax
 60a:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 60e:	84 c0                	test   %al,%al
 610:	0f 84 20 01 00 00    	je     736 <printf+0x15e>
    c = fmt[i] & 0xff;
 616:	0f be f8             	movsbl %al,%edi
 619:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 61c:	85 f6                	test   %esi,%esi
 61e:	75 df                	jne    5ff <printf+0x27>
      if(c == '%'){
 620:	83 f8 25             	cmp    $0x25,%eax
 623:	75 ce                	jne    5f3 <printf+0x1b>
        state = '%';
 625:	89 c6                	mov    %eax,%esi
 627:	eb db                	jmp    604 <printf+0x2c>
      if(c == 'd'){
 629:	83 f8 25             	cmp    $0x25,%eax
 62c:	0f 84 cf 00 00 00    	je     701 <printf+0x129>
 632:	0f 8c dd 00 00 00    	jl     715 <printf+0x13d>
 638:	83 f8 78             	cmp    $0x78,%eax
 63b:	0f 8f d4 00 00 00    	jg     715 <printf+0x13d>
 641:	83 f8 63             	cmp    $0x63,%eax
 644:	0f 8c cb 00 00 00    	jl     715 <printf+0x13d>
 64a:	83 e8 63             	sub    $0x63,%eax
 64d:	83 f8 15             	cmp    $0x15,%eax
 650:	0f 87 bf 00 00 00    	ja     715 <printf+0x13d>
 656:	ff 24 85 dc 08 00 00 	jmp    *0x8dc(,%eax,4)
        printint(fd, *ap, 10, 1);
 65d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 660:	8b 17                	mov    (%edi),%edx
 662:	83 ec 0c             	sub    $0xc,%esp
 665:	6a 01                	push   $0x1
 667:	b9 0a 00 00 00       	mov    $0xa,%ecx
 66c:	8b 45 08             	mov    0x8(%ebp),%eax
 66f:	e8 d9 fe ff ff       	call   54d <printint>
        ap++;
 674:	83 c7 04             	add    $0x4,%edi
 677:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 67a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 67d:	be 00 00 00 00       	mov    $0x0,%esi
 682:	eb 80                	jmp    604 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 684:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 687:	8b 17                	mov    (%edi),%edx
 689:	83 ec 0c             	sub    $0xc,%esp
 68c:	6a 00                	push   $0x0
 68e:	b9 10 00 00 00       	mov    $0x10,%ecx
 693:	8b 45 08             	mov    0x8(%ebp),%eax
 696:	e8 b2 fe ff ff       	call   54d <printint>
        ap++;
 69b:	83 c7 04             	add    $0x4,%edi
 69e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 6a1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6a4:	be 00 00 00 00       	mov    $0x0,%esi
 6a9:	e9 56 ff ff ff       	jmp    604 <printf+0x2c>
        s = (char*)*ap;
 6ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b1:	8b 30                	mov    (%eax),%esi
        ap++;
 6b3:	83 c0 04             	add    $0x4,%eax
 6b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 6b9:	85 f6                	test   %esi,%esi
 6bb:	75 15                	jne    6d2 <printf+0xfa>
          s = "(null)";
 6bd:	be d2 08 00 00       	mov    $0x8d2,%esi
 6c2:	eb 0e                	jmp    6d2 <printf+0xfa>
          putc(fd, *s);
 6c4:	0f be d2             	movsbl %dl,%edx
 6c7:	8b 45 08             	mov    0x8(%ebp),%eax
 6ca:	e8 64 fe ff ff       	call   533 <putc>
          s++;
 6cf:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 6d2:	0f b6 16             	movzbl (%esi),%edx
 6d5:	84 d2                	test   %dl,%dl
 6d7:	75 eb                	jne    6c4 <printf+0xec>
      state = 0;
 6d9:	be 00 00 00 00       	mov    $0x0,%esi
 6de:	e9 21 ff ff ff       	jmp    604 <printf+0x2c>
        putc(fd, *ap);
 6e3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 6e6:	0f be 17             	movsbl (%edi),%edx
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	e8 42 fe ff ff       	call   533 <putc>
        ap++;
 6f1:	83 c7 04             	add    $0x4,%edi
 6f4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 6f7:	be 00 00 00 00       	mov    $0x0,%esi
 6fc:	e9 03 ff ff ff       	jmp    604 <printf+0x2c>
        putc(fd, c);
 701:	89 fa                	mov    %edi,%edx
 703:	8b 45 08             	mov    0x8(%ebp),%eax
 706:	e8 28 fe ff ff       	call   533 <putc>
      state = 0;
 70b:	be 00 00 00 00       	mov    $0x0,%esi
 710:	e9 ef fe ff ff       	jmp    604 <printf+0x2c>
        putc(fd, '%');
 715:	ba 25 00 00 00       	mov    $0x25,%edx
 71a:	8b 45 08             	mov    0x8(%ebp),%eax
 71d:	e8 11 fe ff ff       	call   533 <putc>
        putc(fd, c);
 722:	89 fa                	mov    %edi,%edx
 724:	8b 45 08             	mov    0x8(%ebp),%eax
 727:	e8 07 fe ff ff       	call   533 <putc>
      state = 0;
 72c:	be 00 00 00 00       	mov    $0x0,%esi
 731:	e9 ce fe ff ff       	jmp    604 <printf+0x2c>
    }
  }
}
 736:	8d 65 f4             	lea    -0xc(%ebp),%esp
 739:	5b                   	pop    %ebx
 73a:	5e                   	pop    %esi
 73b:	5f                   	pop    %edi
 73c:	5d                   	pop    %ebp
 73d:	c3                   	ret    

0000073e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 73e:	55                   	push   %ebp
 73f:	89 e5                	mov    %esp,%ebp
 741:	57                   	push   %edi
 742:	56                   	push   %esi
 743:	53                   	push   %ebx
 744:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 747:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	a1 4c 0c 00 00       	mov    0xc4c,%eax
 74f:	eb 02                	jmp    753 <free+0x15>
 751:	89 d0                	mov    %edx,%eax
 753:	39 c8                	cmp    %ecx,%eax
 755:	73 04                	jae    75b <free+0x1d>
 757:	39 08                	cmp    %ecx,(%eax)
 759:	77 12                	ja     76d <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75b:	8b 10                	mov    (%eax),%edx
 75d:	39 c2                	cmp    %eax,%edx
 75f:	77 f0                	ja     751 <free+0x13>
 761:	39 c8                	cmp    %ecx,%eax
 763:	72 08                	jb     76d <free+0x2f>
 765:	39 ca                	cmp    %ecx,%edx
 767:	77 04                	ja     76d <free+0x2f>
 769:	89 d0                	mov    %edx,%eax
 76b:	eb e6                	jmp    753 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 76d:	8b 73 fc             	mov    -0x4(%ebx),%esi
 770:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 773:	8b 10                	mov    (%eax),%edx
 775:	39 d7                	cmp    %edx,%edi
 777:	74 19                	je     792 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 779:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77c:	8b 50 04             	mov    0x4(%eax),%edx
 77f:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 782:	39 ce                	cmp    %ecx,%esi
 784:	74 1b                	je     7a1 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 786:	89 08                	mov    %ecx,(%eax)
  freep = p;
 788:	a3 4c 0c 00 00       	mov    %eax,0xc4c
}
 78d:	5b                   	pop    %ebx
 78e:	5e                   	pop    %esi
 78f:	5f                   	pop    %edi
 790:	5d                   	pop    %ebp
 791:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 792:	03 72 04             	add    0x4(%edx),%esi
 795:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 798:	8b 10                	mov    (%eax),%edx
 79a:	8b 12                	mov    (%edx),%edx
 79c:	89 53 f8             	mov    %edx,-0x8(%ebx)
 79f:	eb db                	jmp    77c <free+0x3e>
    p->s.size += bp->s.size;
 7a1:	03 53 fc             	add    -0x4(%ebx),%edx
 7a4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7a7:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7aa:	89 10                	mov    %edx,(%eax)
 7ac:	eb da                	jmp    788 <free+0x4a>

000007ae <morecore>:

static Header*
morecore(uint nu)
{
 7ae:	55                   	push   %ebp
 7af:	89 e5                	mov    %esp,%ebp
 7b1:	53                   	push   %ebx
 7b2:	83 ec 04             	sub    $0x4,%esp
 7b5:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 7b7:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 7bc:	77 05                	ja     7c3 <morecore+0x15>
    nu = 4096;
 7be:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 7c3:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7ca:	83 ec 0c             	sub    $0xc,%esp
 7cd:	50                   	push   %eax
 7ce:	e8 38 fd ff ff       	call   50b <sbrk>
  if(p == (char*)-1)
 7d3:	83 c4 10             	add    $0x10,%esp
 7d6:	83 f8 ff             	cmp    $0xffffffff,%eax
 7d9:	74 1c                	je     7f7 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7db:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7de:	83 c0 08             	add    $0x8,%eax
 7e1:	83 ec 0c             	sub    $0xc,%esp
 7e4:	50                   	push   %eax
 7e5:	e8 54 ff ff ff       	call   73e <free>
  return freep;
 7ea:	a1 4c 0c 00 00       	mov    0xc4c,%eax
 7ef:	83 c4 10             	add    $0x10,%esp
}
 7f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7f5:	c9                   	leave  
 7f6:	c3                   	ret    
    return 0;
 7f7:	b8 00 00 00 00       	mov    $0x0,%eax
 7fc:	eb f4                	jmp    7f2 <morecore+0x44>

000007fe <malloc>:

void*
malloc(uint nbytes)
{
 7fe:	55                   	push   %ebp
 7ff:	89 e5                	mov    %esp,%ebp
 801:	53                   	push   %ebx
 802:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 805:	8b 45 08             	mov    0x8(%ebp),%eax
 808:	8d 58 07             	lea    0x7(%eax),%ebx
 80b:	c1 eb 03             	shr    $0x3,%ebx
 80e:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 811:	8b 0d 4c 0c 00 00    	mov    0xc4c,%ecx
 817:	85 c9                	test   %ecx,%ecx
 819:	74 04                	je     81f <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81b:	8b 01                	mov    (%ecx),%eax
 81d:	eb 4a                	jmp    869 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
 81f:	c7 05 4c 0c 00 00 50 	movl   $0xc50,0xc4c
 826:	0c 00 00 
 829:	c7 05 50 0c 00 00 50 	movl   $0xc50,0xc50
 830:	0c 00 00 
    base.s.size = 0;
 833:	c7 05 54 0c 00 00 00 	movl   $0x0,0xc54
 83a:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 83d:	b9 50 0c 00 00       	mov    $0xc50,%ecx
 842:	eb d7                	jmp    81b <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 844:	74 19                	je     85f <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 846:	29 da                	sub    %ebx,%edx
 848:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 84b:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 84e:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 851:	89 0d 4c 0c 00 00    	mov    %ecx,0xc4c
      return (void*)(p + 1);
 857:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 85a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 85d:	c9                   	leave  
 85e:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 85f:	8b 10                	mov    (%eax),%edx
 861:	89 11                	mov    %edx,(%ecx)
 863:	eb ec                	jmp    851 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 865:	89 c1                	mov    %eax,%ecx
 867:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 869:	8b 50 04             	mov    0x4(%eax),%edx
 86c:	39 da                	cmp    %ebx,%edx
 86e:	73 d4                	jae    844 <malloc+0x46>
    if(p == freep)
 870:	39 05 4c 0c 00 00    	cmp    %eax,0xc4c
 876:	75 ed                	jne    865 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
 878:	89 d8                	mov    %ebx,%eax
 87a:	e8 2f ff ff ff       	call   7ae <morecore>
 87f:	85 c0                	test   %eax,%eax
 881:	75 e2                	jne    865 <malloc+0x67>
 883:	eb d5                	jmp    85a <malloc+0x5c>
