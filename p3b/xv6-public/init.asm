
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 80 06 00 00       	push   $0x680
  19:	e8 9e 02 00 00       	call   2bc <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	78 1b                	js     40 <main+0x40>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  25:	83 ec 0c             	sub    $0xc,%esp
  28:	6a 00                	push   $0x0
  2a:	e8 c5 02 00 00       	call   2f4 <dup>
  dup(0);  // stderr
  2f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  36:	e8 b9 02 00 00       	call   2f4 <dup>
  3b:	83 c4 10             	add    $0x10,%esp
  3e:	eb 58                	jmp    98 <main+0x98>
    mknod("console", 1, 1);
  40:	83 ec 04             	sub    $0x4,%esp
  43:	6a 01                	push   $0x1
  45:	6a 01                	push   $0x1
  47:	68 80 06 00 00       	push   $0x680
  4c:	e8 73 02 00 00       	call   2c4 <mknod>
    open("console", O_RDWR);
  51:	83 c4 08             	add    $0x8,%esp
  54:	6a 02                	push   $0x2
  56:	68 80 06 00 00       	push   $0x680
  5b:	e8 5c 02 00 00       	call   2bc <open>
  60:	83 c4 10             	add    $0x10,%esp
  63:	eb c0                	jmp    25 <main+0x25>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  65:	83 ec 08             	sub    $0x8,%esp
  68:	68 9b 06 00 00       	push   $0x69b
  6d:	6a 01                	push   $0x1
  6f:	e8 5d 03 00 00       	call   3d1 <printf>
      exit();
  74:	e8 03 02 00 00       	call   27c <exit>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  79:	83 ec 08             	sub    $0x8,%esp
  7c:	68 c7 06 00 00       	push   $0x6c7
  81:	6a 01                	push   $0x1
  83:	e8 49 03 00 00       	call   3d1 <printf>
  88:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
  8b:	e8 f4 01 00 00       	call   284 <wait>
  90:	85 c0                	test   %eax,%eax
  92:	78 04                	js     98 <main+0x98>
  94:	39 c3                	cmp    %eax,%ebx
  96:	75 e1                	jne    79 <main+0x79>
    printf(1, "init: starting sh\n");
  98:	83 ec 08             	sub    $0x8,%esp
  9b:	68 88 06 00 00       	push   $0x688
  a0:	6a 01                	push   $0x1
  a2:	e8 2a 03 00 00       	call   3d1 <printf>
    pid = fork();
  a7:	e8 c8 01 00 00       	call   274 <fork>
  ac:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  ae:	83 c4 10             	add    $0x10,%esp
  b1:	85 c0                	test   %eax,%eax
  b3:	78 b0                	js     65 <main+0x65>
    if(pid == 0){
  b5:	75 d4                	jne    8b <main+0x8b>
      exec("sh", argv);
  b7:	83 ec 08             	sub    $0x8,%esp
  ba:	68 d4 09 00 00       	push   $0x9d4
  bf:	68 ae 06 00 00       	push   $0x6ae
  c4:	e8 eb 01 00 00       	call   2b4 <exec>
      printf(1, "init: exec sh failed\n");
  c9:	83 c4 08             	add    $0x8,%esp
  cc:	68 b1 06 00 00       	push   $0x6b1
  d1:	6a 01                	push   $0x1
  d3:	e8 f9 02 00 00       	call   3d1 <printf>
      exit();
  d8:	e8 9f 01 00 00       	call   27c <exit>

000000dd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  e0:	56                   	push   %esi
  e1:	53                   	push   %ebx
  e2:	8b 75 08             	mov    0x8(%ebp),%esi
  e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e8:	89 f0                	mov    %esi,%eax
  ea:	89 d1                	mov    %edx,%ecx
  ec:	83 c2 01             	add    $0x1,%edx
  ef:	89 c3                	mov    %eax,%ebx
  f1:	83 c0 01             	add    $0x1,%eax
  f4:	0f b6 09             	movzbl (%ecx),%ecx
  f7:	88 0b                	mov    %cl,(%ebx)
  f9:	84 c9                	test   %cl,%cl
  fb:	75 ed                	jne    ea <strcpy+0xd>
    ;
  return os;
}
  fd:	89 f0                	mov    %esi,%eax
  ff:	5b                   	pop    %ebx
 100:	5e                   	pop    %esi
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    

00000103 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 10c:	eb 06                	jmp    114 <strcmp+0x11>
    p++, q++;
 10e:	83 c1 01             	add    $0x1,%ecx
 111:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 114:	0f b6 01             	movzbl (%ecx),%eax
 117:	84 c0                	test   %al,%al
 119:	74 04                	je     11f <strcmp+0x1c>
 11b:	3a 02                	cmp    (%edx),%al
 11d:	74 ef                	je     10e <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 11f:	0f b6 c0             	movzbl %al,%eax
 122:	0f b6 12             	movzbl (%edx),%edx
 125:	29 d0                	sub    %edx,%eax
}
 127:	5d                   	pop    %ebp
 128:	c3                   	ret    

00000129 <strlen>:

uint
strlen(const char *s)
{
 129:	55                   	push   %ebp
 12a:	89 e5                	mov    %esp,%ebp
 12c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 12f:	b8 00 00 00 00       	mov    $0x0,%eax
 134:	eb 03                	jmp    139 <strlen+0x10>
 136:	83 c0 01             	add    $0x1,%eax
 139:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 13d:	75 f7                	jne    136 <strlen+0xd>
    ;
  return n;
}
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    

00000141 <memset>:

void*
memset(void *dst, int c, uint n)
{
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	57                   	push   %edi
 145:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 148:	89 d7                	mov    %edx,%edi
 14a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14d:	8b 45 0c             	mov    0xc(%ebp),%eax
 150:	fc                   	cld    
 151:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 153:	89 d0                	mov    %edx,%eax
 155:	8b 7d fc             	mov    -0x4(%ebp),%edi
 158:	c9                   	leave  
 159:	c3                   	ret    

0000015a <strchr>:

char*
strchr(const char *s, char c)
{
 15a:	55                   	push   %ebp
 15b:	89 e5                	mov    %esp,%ebp
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 164:	eb 03                	jmp    169 <strchr+0xf>
 166:	83 c0 01             	add    $0x1,%eax
 169:	0f b6 10             	movzbl (%eax),%edx
 16c:	84 d2                	test   %dl,%dl
 16e:	74 06                	je     176 <strchr+0x1c>
    if(*s == c)
 170:	38 ca                	cmp    %cl,%dl
 172:	75 f2                	jne    166 <strchr+0xc>
 174:	eb 05                	jmp    17b <strchr+0x21>
      return (char*)s;
  return 0;
 176:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
 17d:	55                   	push   %ebp
 17e:	89 e5                	mov    %esp,%ebp
 180:	57                   	push   %edi
 181:	56                   	push   %esi
 182:	53                   	push   %ebx
 183:	83 ec 1c             	sub    $0x1c,%esp
 186:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 189:	bb 00 00 00 00       	mov    $0x0,%ebx
 18e:	89 de                	mov    %ebx,%esi
 190:	83 c3 01             	add    $0x1,%ebx
 193:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 196:	7d 2e                	jge    1c6 <gets+0x49>
    cc = read(0, &c, 1);
 198:	83 ec 04             	sub    $0x4,%esp
 19b:	6a 01                	push   $0x1
 19d:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1a0:	50                   	push   %eax
 1a1:	6a 00                	push   $0x0
 1a3:	e8 ec 00 00 00       	call   294 <read>
    if(cc < 1)
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	85 c0                	test   %eax,%eax
 1ad:	7e 17                	jle    1c6 <gets+0x49>
      break;
    buf[i++] = c;
 1af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b3:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 1b6:	3c 0a                	cmp    $0xa,%al
 1b8:	0f 94 c2             	sete   %dl
 1bb:	3c 0d                	cmp    $0xd,%al
 1bd:	0f 94 c0             	sete   %al
 1c0:	08 c2                	or     %al,%dl
 1c2:	74 ca                	je     18e <gets+0x11>
    buf[i++] = c;
 1c4:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1c6:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1ca:	89 f8                	mov    %edi,%eax
 1cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1cf:	5b                   	pop    %ebx
 1d0:	5e                   	pop    %esi
 1d1:	5f                   	pop    %edi
 1d2:	5d                   	pop    %ebp
 1d3:	c3                   	ret    

000001d4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	56                   	push   %esi
 1d8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	6a 00                	push   $0x0
 1de:	ff 75 08             	push   0x8(%ebp)
 1e1:	e8 d6 00 00 00       	call   2bc <open>
  if(fd < 0)
 1e6:	83 c4 10             	add    $0x10,%esp
 1e9:	85 c0                	test   %eax,%eax
 1eb:	78 24                	js     211 <stat+0x3d>
 1ed:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1ef:	83 ec 08             	sub    $0x8,%esp
 1f2:	ff 75 0c             	push   0xc(%ebp)
 1f5:	50                   	push   %eax
 1f6:	e8 d9 00 00 00       	call   2d4 <fstat>
 1fb:	89 c6                	mov    %eax,%esi
  close(fd);
 1fd:	89 1c 24             	mov    %ebx,(%esp)
 200:	e8 9f 00 00 00       	call   2a4 <close>
  return r;
 205:	83 c4 10             	add    $0x10,%esp
}
 208:	89 f0                	mov    %esi,%eax
 20a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20d:	5b                   	pop    %ebx
 20e:	5e                   	pop    %esi
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret    
    return -1;
 211:	be ff ff ff ff       	mov    $0xffffffff,%esi
 216:	eb f0                	jmp    208 <stat+0x34>

00000218 <atoi>:

int
atoi(const char *s)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	53                   	push   %ebx
 21c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 21f:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 224:	eb 10                	jmp    236 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 226:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 229:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 22c:	83 c1 01             	add    $0x1,%ecx
 22f:	0f be c0             	movsbl %al,%eax
 232:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
 236:	0f b6 01             	movzbl (%ecx),%eax
 239:	8d 58 d0             	lea    -0x30(%eax),%ebx
 23c:	80 fb 09             	cmp    $0x9,%bl
 23f:	76 e5                	jbe    226 <atoi+0xe>
  return n;
}
 241:	89 d0                	mov    %edx,%eax
 243:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 246:	c9                   	leave  
 247:	c3                   	ret    

00000248 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 248:	55                   	push   %ebp
 249:	89 e5                	mov    %esp,%ebp
 24b:	56                   	push   %esi
 24c:	53                   	push   %ebx
 24d:	8b 75 08             	mov    0x8(%ebp),%esi
 250:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 253:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 256:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 258:	eb 0d                	jmp    267 <memmove+0x1f>
    *dst++ = *src++;
 25a:	0f b6 01             	movzbl (%ecx),%eax
 25d:	88 02                	mov    %al,(%edx)
 25f:	8d 49 01             	lea    0x1(%ecx),%ecx
 262:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 265:	89 d8                	mov    %ebx,%eax
 267:	8d 58 ff             	lea    -0x1(%eax),%ebx
 26a:	85 c0                	test   %eax,%eax
 26c:	7f ec                	jg     25a <memmove+0x12>
  return vdst;
}
 26e:	89 f0                	mov    %esi,%eax
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    

00000274 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 274:	b8 01 00 00 00       	mov    $0x1,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <exit>:
SYSCALL(exit)
 27c:	b8 02 00 00 00       	mov    $0x2,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <wait>:
SYSCALL(wait)
 284:	b8 03 00 00 00       	mov    $0x3,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <pipe>:
SYSCALL(pipe)
 28c:	b8 04 00 00 00       	mov    $0x4,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <read>:
SYSCALL(read)
 294:	b8 05 00 00 00       	mov    $0x5,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <write>:
SYSCALL(write)
 29c:	b8 10 00 00 00       	mov    $0x10,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <close>:
SYSCALL(close)
 2a4:	b8 15 00 00 00       	mov    $0x15,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <kill>:
SYSCALL(kill)
 2ac:	b8 06 00 00 00       	mov    $0x6,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <exec>:
SYSCALL(exec)
 2b4:	b8 07 00 00 00       	mov    $0x7,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <open>:
SYSCALL(open)
 2bc:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <mknod>:
SYSCALL(mknod)
 2c4:	b8 11 00 00 00       	mov    $0x11,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <unlink>:
SYSCALL(unlink)
 2cc:	b8 12 00 00 00       	mov    $0x12,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <fstat>:
SYSCALL(fstat)
 2d4:	b8 08 00 00 00       	mov    $0x8,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <link>:
SYSCALL(link)
 2dc:	b8 13 00 00 00       	mov    $0x13,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <mkdir>:
SYSCALL(mkdir)
 2e4:	b8 14 00 00 00       	mov    $0x14,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <chdir>:
SYSCALL(chdir)
 2ec:	b8 09 00 00 00       	mov    $0x9,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <dup>:
SYSCALL(dup)
 2f4:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <getpid>:
SYSCALL(getpid)
 2fc:	b8 0b 00 00 00       	mov    $0xb,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <sbrk>:
SYSCALL(sbrk)
 304:	b8 0c 00 00 00       	mov    $0xc,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <sleep>:
SYSCALL(sleep)
 30c:	b8 0d 00 00 00       	mov    $0xd,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <uptime>:
SYSCALL(uptime)
 314:	b8 0e 00 00 00       	mov    $0xe,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <clone>:
SYSCALL(clone)
 31c:	b8 16 00 00 00       	mov    $0x16,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <join>:
SYSCALL(join)
 324:	b8 17 00 00 00       	mov    $0x17,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	83 ec 1c             	sub    $0x1c,%esp
 332:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 335:	6a 01                	push   $0x1
 337:	8d 55 f4             	lea    -0xc(%ebp),%edx
 33a:	52                   	push   %edx
 33b:	50                   	push   %eax
 33c:	e8 5b ff ff ff       	call   29c <write>
}
 341:	83 c4 10             	add    $0x10,%esp
 344:	c9                   	leave  
 345:	c3                   	ret    

00000346 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	57                   	push   %edi
 34a:	56                   	push   %esi
 34b:	53                   	push   %ebx
 34c:	83 ec 2c             	sub    $0x2c,%esp
 34f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 352:	89 d0                	mov    %edx,%eax
 354:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 356:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 35a:	0f 95 c1             	setne  %cl
 35d:	c1 ea 1f             	shr    $0x1f,%edx
 360:	84 d1                	test   %dl,%cl
 362:	74 44                	je     3a8 <printint+0x62>
    neg = 1;
    x = -xx;
 364:	f7 d8                	neg    %eax
 366:	89 c1                	mov    %eax,%ecx
    neg = 1;
 368:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 36f:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 374:	89 c8                	mov    %ecx,%eax
 376:	ba 00 00 00 00       	mov    $0x0,%edx
 37b:	f7 f6                	div    %esi
 37d:	89 df                	mov    %ebx,%edi
 37f:	83 c3 01             	add    $0x1,%ebx
 382:	0f b6 92 30 07 00 00 	movzbl 0x730(%edx),%edx
 389:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 38d:	89 ca                	mov    %ecx,%edx
 38f:	89 c1                	mov    %eax,%ecx
 391:	39 d6                	cmp    %edx,%esi
 393:	76 df                	jbe    374 <printint+0x2e>
  if(neg)
 395:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 399:	74 31                	je     3cc <printint+0x86>
    buf[i++] = '-';
 39b:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3a0:	8d 5f 02             	lea    0x2(%edi),%ebx
 3a3:	8b 75 d0             	mov    -0x30(%ebp),%esi
 3a6:	eb 17                	jmp    3bf <printint+0x79>
    x = xx;
 3a8:	89 c1                	mov    %eax,%ecx
  neg = 0;
 3aa:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 3b1:	eb bc                	jmp    36f <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
 3b3:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 3b8:	89 f0                	mov    %esi,%eax
 3ba:	e8 6d ff ff ff       	call   32c <putc>
  while(--i >= 0)
 3bf:	83 eb 01             	sub    $0x1,%ebx
 3c2:	79 ef                	jns    3b3 <printint+0x6d>
}
 3c4:	83 c4 2c             	add    $0x2c,%esp
 3c7:	5b                   	pop    %ebx
 3c8:	5e                   	pop    %esi
 3c9:	5f                   	pop    %edi
 3ca:	5d                   	pop    %ebp
 3cb:	c3                   	ret    
 3cc:	8b 75 d0             	mov    -0x30(%ebp),%esi
 3cf:	eb ee                	jmp    3bf <printint+0x79>

000003d1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3d1:	55                   	push   %ebp
 3d2:	89 e5                	mov    %esp,%ebp
 3d4:	57                   	push   %edi
 3d5:	56                   	push   %esi
 3d6:	53                   	push   %ebx
 3d7:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3da:	8d 45 10             	lea    0x10(%ebp),%eax
 3dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 3e0:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 3e5:	bb 00 00 00 00       	mov    $0x0,%ebx
 3ea:	eb 14                	jmp    400 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 3ec:	89 fa                	mov    %edi,%edx
 3ee:	8b 45 08             	mov    0x8(%ebp),%eax
 3f1:	e8 36 ff ff ff       	call   32c <putc>
 3f6:	eb 05                	jmp    3fd <printf+0x2c>
      }
    } else if(state == '%'){
 3f8:	83 fe 25             	cmp    $0x25,%esi
 3fb:	74 25                	je     422 <printf+0x51>
  for(i = 0; fmt[i]; i++){
 3fd:	83 c3 01             	add    $0x1,%ebx
 400:	8b 45 0c             	mov    0xc(%ebp),%eax
 403:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 407:	84 c0                	test   %al,%al
 409:	0f 84 20 01 00 00    	je     52f <printf+0x15e>
    c = fmt[i] & 0xff;
 40f:	0f be f8             	movsbl %al,%edi
 412:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 415:	85 f6                	test   %esi,%esi
 417:	75 df                	jne    3f8 <printf+0x27>
      if(c == '%'){
 419:	83 f8 25             	cmp    $0x25,%eax
 41c:	75 ce                	jne    3ec <printf+0x1b>
        state = '%';
 41e:	89 c6                	mov    %eax,%esi
 420:	eb db                	jmp    3fd <printf+0x2c>
      if(c == 'd'){
 422:	83 f8 25             	cmp    $0x25,%eax
 425:	0f 84 cf 00 00 00    	je     4fa <printf+0x129>
 42b:	0f 8c dd 00 00 00    	jl     50e <printf+0x13d>
 431:	83 f8 78             	cmp    $0x78,%eax
 434:	0f 8f d4 00 00 00    	jg     50e <printf+0x13d>
 43a:	83 f8 63             	cmp    $0x63,%eax
 43d:	0f 8c cb 00 00 00    	jl     50e <printf+0x13d>
 443:	83 e8 63             	sub    $0x63,%eax
 446:	83 f8 15             	cmp    $0x15,%eax
 449:	0f 87 bf 00 00 00    	ja     50e <printf+0x13d>
 44f:	ff 24 85 d8 06 00 00 	jmp    *0x6d8(,%eax,4)
        printint(fd, *ap, 10, 1);
 456:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 459:	8b 17                	mov    (%edi),%edx
 45b:	83 ec 0c             	sub    $0xc,%esp
 45e:	6a 01                	push   $0x1
 460:	b9 0a 00 00 00       	mov    $0xa,%ecx
 465:	8b 45 08             	mov    0x8(%ebp),%eax
 468:	e8 d9 fe ff ff       	call   346 <printint>
        ap++;
 46d:	83 c7 04             	add    $0x4,%edi
 470:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 473:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 476:	be 00 00 00 00       	mov    $0x0,%esi
 47b:	eb 80                	jmp    3fd <printf+0x2c>
        printint(fd, *ap, 16, 0);
 47d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 480:	8b 17                	mov    (%edi),%edx
 482:	83 ec 0c             	sub    $0xc,%esp
 485:	6a 00                	push   $0x0
 487:	b9 10 00 00 00       	mov    $0x10,%ecx
 48c:	8b 45 08             	mov    0x8(%ebp),%eax
 48f:	e8 b2 fe ff ff       	call   346 <printint>
        ap++;
 494:	83 c7 04             	add    $0x4,%edi
 497:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 49a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 49d:	be 00 00 00 00       	mov    $0x0,%esi
 4a2:	e9 56 ff ff ff       	jmp    3fd <printf+0x2c>
        s = (char*)*ap;
 4a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4aa:	8b 30                	mov    (%eax),%esi
        ap++;
 4ac:	83 c0 04             	add    $0x4,%eax
 4af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 4b2:	85 f6                	test   %esi,%esi
 4b4:	75 15                	jne    4cb <printf+0xfa>
          s = "(null)";
 4b6:	be d0 06 00 00       	mov    $0x6d0,%esi
 4bb:	eb 0e                	jmp    4cb <printf+0xfa>
          putc(fd, *s);
 4bd:	0f be d2             	movsbl %dl,%edx
 4c0:	8b 45 08             	mov    0x8(%ebp),%eax
 4c3:	e8 64 fe ff ff       	call   32c <putc>
          s++;
 4c8:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 4cb:	0f b6 16             	movzbl (%esi),%edx
 4ce:	84 d2                	test   %dl,%dl
 4d0:	75 eb                	jne    4bd <printf+0xec>
      state = 0;
 4d2:	be 00 00 00 00       	mov    $0x0,%esi
 4d7:	e9 21 ff ff ff       	jmp    3fd <printf+0x2c>
        putc(fd, *ap);
 4dc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4df:	0f be 17             	movsbl (%edi),%edx
 4e2:	8b 45 08             	mov    0x8(%ebp),%eax
 4e5:	e8 42 fe ff ff       	call   32c <putc>
        ap++;
 4ea:	83 c7 04             	add    $0x4,%edi
 4ed:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 4f0:	be 00 00 00 00       	mov    $0x0,%esi
 4f5:	e9 03 ff ff ff       	jmp    3fd <printf+0x2c>
        putc(fd, c);
 4fa:	89 fa                	mov    %edi,%edx
 4fc:	8b 45 08             	mov    0x8(%ebp),%eax
 4ff:	e8 28 fe ff ff       	call   32c <putc>
      state = 0;
 504:	be 00 00 00 00       	mov    $0x0,%esi
 509:	e9 ef fe ff ff       	jmp    3fd <printf+0x2c>
        putc(fd, '%');
 50e:	ba 25 00 00 00       	mov    $0x25,%edx
 513:	8b 45 08             	mov    0x8(%ebp),%eax
 516:	e8 11 fe ff ff       	call   32c <putc>
        putc(fd, c);
 51b:	89 fa                	mov    %edi,%edx
 51d:	8b 45 08             	mov    0x8(%ebp),%eax
 520:	e8 07 fe ff ff       	call   32c <putc>
      state = 0;
 525:	be 00 00 00 00       	mov    $0x0,%esi
 52a:	e9 ce fe ff ff       	jmp    3fd <printf+0x2c>
    }
  }
}
 52f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 532:	5b                   	pop    %ebx
 533:	5e                   	pop    %esi
 534:	5f                   	pop    %edi
 535:	5d                   	pop    %ebp
 536:	c3                   	ret    

00000537 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 537:	55                   	push   %ebp
 538:	89 e5                	mov    %esp,%ebp
 53a:	57                   	push   %edi
 53b:	56                   	push   %esi
 53c:	53                   	push   %ebx
 53d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 540:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 543:	a1 dc 09 00 00       	mov    0x9dc,%eax
 548:	eb 02                	jmp    54c <free+0x15>
 54a:	89 d0                	mov    %edx,%eax
 54c:	39 c8                	cmp    %ecx,%eax
 54e:	73 04                	jae    554 <free+0x1d>
 550:	39 08                	cmp    %ecx,(%eax)
 552:	77 12                	ja     566 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 554:	8b 10                	mov    (%eax),%edx
 556:	39 c2                	cmp    %eax,%edx
 558:	77 f0                	ja     54a <free+0x13>
 55a:	39 c8                	cmp    %ecx,%eax
 55c:	72 08                	jb     566 <free+0x2f>
 55e:	39 ca                	cmp    %ecx,%edx
 560:	77 04                	ja     566 <free+0x2f>
 562:	89 d0                	mov    %edx,%eax
 564:	eb e6                	jmp    54c <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 566:	8b 73 fc             	mov    -0x4(%ebx),%esi
 569:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 56c:	8b 10                	mov    (%eax),%edx
 56e:	39 d7                	cmp    %edx,%edi
 570:	74 19                	je     58b <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 572:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 575:	8b 50 04             	mov    0x4(%eax),%edx
 578:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 57b:	39 ce                	cmp    %ecx,%esi
 57d:	74 1b                	je     59a <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 57f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 581:	a3 dc 09 00 00       	mov    %eax,0x9dc
}
 586:	5b                   	pop    %ebx
 587:	5e                   	pop    %esi
 588:	5f                   	pop    %edi
 589:	5d                   	pop    %ebp
 58a:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 58b:	03 72 04             	add    0x4(%edx),%esi
 58e:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 591:	8b 10                	mov    (%eax),%edx
 593:	8b 12                	mov    (%edx),%edx
 595:	89 53 f8             	mov    %edx,-0x8(%ebx)
 598:	eb db                	jmp    575 <free+0x3e>
    p->s.size += bp->s.size;
 59a:	03 53 fc             	add    -0x4(%ebx),%edx
 59d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5a0:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5a3:	89 10                	mov    %edx,(%eax)
 5a5:	eb da                	jmp    581 <free+0x4a>

000005a7 <morecore>:

static Header*
morecore(uint nu)
{
 5a7:	55                   	push   %ebp
 5a8:	89 e5                	mov    %esp,%ebp
 5aa:	53                   	push   %ebx
 5ab:	83 ec 04             	sub    $0x4,%esp
 5ae:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 5b0:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 5b5:	77 05                	ja     5bc <morecore+0x15>
    nu = 4096;
 5b7:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 5bc:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 5c3:	83 ec 0c             	sub    $0xc,%esp
 5c6:	50                   	push   %eax
 5c7:	e8 38 fd ff ff       	call   304 <sbrk>
  if(p == (char*)-1)
 5cc:	83 c4 10             	add    $0x10,%esp
 5cf:	83 f8 ff             	cmp    $0xffffffff,%eax
 5d2:	74 1c                	je     5f0 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5d4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5d7:	83 c0 08             	add    $0x8,%eax
 5da:	83 ec 0c             	sub    $0xc,%esp
 5dd:	50                   	push   %eax
 5de:	e8 54 ff ff ff       	call   537 <free>
  return freep;
 5e3:	a1 dc 09 00 00       	mov    0x9dc,%eax
 5e8:	83 c4 10             	add    $0x10,%esp
}
 5eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5ee:	c9                   	leave  
 5ef:	c3                   	ret    
    return 0;
 5f0:	b8 00 00 00 00       	mov    $0x0,%eax
 5f5:	eb f4                	jmp    5eb <morecore+0x44>

000005f7 <malloc>:

void*
malloc(uint nbytes)
{
 5f7:	55                   	push   %ebp
 5f8:	89 e5                	mov    %esp,%ebp
 5fa:	53                   	push   %ebx
 5fb:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	8d 58 07             	lea    0x7(%eax),%ebx
 604:	c1 eb 03             	shr    $0x3,%ebx
 607:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 60a:	8b 0d dc 09 00 00    	mov    0x9dc,%ecx
 610:	85 c9                	test   %ecx,%ecx
 612:	74 04                	je     618 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 614:	8b 01                	mov    (%ecx),%eax
 616:	eb 4a                	jmp    662 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
 618:	c7 05 dc 09 00 00 e0 	movl   $0x9e0,0x9dc
 61f:	09 00 00 
 622:	c7 05 e0 09 00 00 e0 	movl   $0x9e0,0x9e0
 629:	09 00 00 
    base.s.size = 0;
 62c:	c7 05 e4 09 00 00 00 	movl   $0x0,0x9e4
 633:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 636:	b9 e0 09 00 00       	mov    $0x9e0,%ecx
 63b:	eb d7                	jmp    614 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 63d:	74 19                	je     658 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 63f:	29 da                	sub    %ebx,%edx
 641:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 644:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 647:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 64a:	89 0d dc 09 00 00    	mov    %ecx,0x9dc
      return (void*)(p + 1);
 650:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 653:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 656:	c9                   	leave  
 657:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 658:	8b 10                	mov    (%eax),%edx
 65a:	89 11                	mov    %edx,(%ecx)
 65c:	eb ec                	jmp    64a <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 65e:	89 c1                	mov    %eax,%ecx
 660:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 662:	8b 50 04             	mov    0x4(%eax),%edx
 665:	39 da                	cmp    %ebx,%edx
 667:	73 d4                	jae    63d <malloc+0x46>
    if(p == freep)
 669:	39 05 dc 09 00 00    	cmp    %eax,0x9dc
 66f:	75 ed                	jne    65e <malloc+0x67>
      if((p = morecore(nunits)) == 0)
 671:	89 d8                	mov    %ebx,%eax
 673:	e8 2f ff ff ff       	call   5a7 <morecore>
 678:	85 c0                	test   %eax,%eax
 67a:	75 e2                	jne    65e <malloc+0x67>
 67c:	eb d5                	jmp    653 <malloc+0x5c>
