
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  12:	83 39 03             	cmpl   $0x3,(%ecx)
  15:	74 14                	je     2b <main+0x2b>
    printf(2, "Usage: ln old new\n");
  17:	83 ec 08             	sub    $0x8,%esp
  1a:	68 00 06 00 00       	push   $0x600
  1f:	6a 02                	push   $0x2
  21:	e8 2a 03 00 00       	call   350 <printf>
    exit();
  26:	e8 d0 01 00 00       	call   1fb <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2b:	83 ec 08             	sub    $0x8,%esp
  2e:	ff 73 08             	push   0x8(%ebx)
  31:	ff 73 04             	push   0x4(%ebx)
  34:	e8 22 02 00 00       	call   25b <link>
  39:	83 c4 10             	add    $0x10,%esp
  3c:	85 c0                	test   %eax,%eax
  3e:	78 05                	js     45 <main+0x45>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  40:	e8 b6 01 00 00       	call   1fb <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  45:	ff 73 08             	push   0x8(%ebx)
  48:	ff 73 04             	push   0x4(%ebx)
  4b:	68 13 06 00 00       	push   $0x613
  50:	6a 02                	push   $0x2
  52:	e8 f9 02 00 00       	call   350 <printf>
  57:	83 c4 10             	add    $0x10,%esp
  5a:	eb e4                	jmp    40 <main+0x40>

0000005c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  5c:	55                   	push   %ebp
  5d:	89 e5                	mov    %esp,%ebp
  5f:	56                   	push   %esi
  60:	53                   	push   %ebx
  61:	8b 75 08             	mov    0x8(%ebp),%esi
  64:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  67:	89 f0                	mov    %esi,%eax
  69:	89 d1                	mov    %edx,%ecx
  6b:	83 c2 01             	add    $0x1,%edx
  6e:	89 c3                	mov    %eax,%ebx
  70:	83 c0 01             	add    $0x1,%eax
  73:	0f b6 09             	movzbl (%ecx),%ecx
  76:	88 0b                	mov    %cl,(%ebx)
  78:	84 c9                	test   %cl,%cl
  7a:	75 ed                	jne    69 <strcpy+0xd>
    ;
  return os;
}
  7c:	89 f0                	mov    %esi,%eax
  7e:	5b                   	pop    %ebx
  7f:	5e                   	pop    %esi
  80:	5d                   	pop    %ebp
  81:	c3                   	ret    

00000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	55                   	push   %ebp
  83:	89 e5                	mov    %esp,%ebp
  85:	8b 4d 08             	mov    0x8(%ebp),%ecx
  88:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  8b:	eb 06                	jmp    93 <strcmp+0x11>
    p++, q++;
  8d:	83 c1 01             	add    $0x1,%ecx
  90:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  93:	0f b6 01             	movzbl (%ecx),%eax
  96:	84 c0                	test   %al,%al
  98:	74 04                	je     9e <strcmp+0x1c>
  9a:	3a 02                	cmp    (%edx),%al
  9c:	74 ef                	je     8d <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
  9e:	0f b6 c0             	movzbl %al,%eax
  a1:	0f b6 12             	movzbl (%edx),%edx
  a4:	29 d0                	sub    %edx,%eax
}
  a6:	5d                   	pop    %ebp
  a7:	c3                   	ret    

000000a8 <strlen>:

uint
strlen(const char *s)
{
  a8:	55                   	push   %ebp
  a9:	89 e5                	mov    %esp,%ebp
  ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ae:	b8 00 00 00 00       	mov    $0x0,%eax
  b3:	eb 03                	jmp    b8 <strlen+0x10>
  b5:	83 c0 01             	add    $0x1,%eax
  b8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  bc:	75 f7                	jne    b5 <strlen+0xd>
    ;
  return n;
}
  be:	5d                   	pop    %ebp
  bf:	c3                   	ret    

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	89 d7                	mov    %edx,%edi
  c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	89 d0                	mov    %edx,%eax
  d4:	8b 7d fc             	mov    -0x4(%ebp),%edi
  d7:	c9                   	leave  
  d8:	c3                   	ret    

000000d9 <strchr>:

char*
strchr(const char *s, char c)
{
  d9:	55                   	push   %ebp
  da:	89 e5                	mov    %esp,%ebp
  dc:	8b 45 08             	mov    0x8(%ebp),%eax
  df:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  e3:	eb 03                	jmp    e8 <strchr+0xf>
  e5:	83 c0 01             	add    $0x1,%eax
  e8:	0f b6 10             	movzbl (%eax),%edx
  eb:	84 d2                	test   %dl,%dl
  ed:	74 06                	je     f5 <strchr+0x1c>
    if(*s == c)
  ef:	38 ca                	cmp    %cl,%dl
  f1:	75 f2                	jne    e5 <strchr+0xc>
  f3:	eb 05                	jmp    fa <strchr+0x21>
      return (char*)s;
  return 0;
  f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  fa:	5d                   	pop    %ebp
  fb:	c3                   	ret    

000000fc <gets>:

char*
gets(char *buf, int max)
{
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	57                   	push   %edi
 100:	56                   	push   %esi
 101:	53                   	push   %ebx
 102:	83 ec 1c             	sub    $0x1c,%esp
 105:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 108:	bb 00 00 00 00       	mov    $0x0,%ebx
 10d:	89 de                	mov    %ebx,%esi
 10f:	83 c3 01             	add    $0x1,%ebx
 112:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 115:	7d 2e                	jge    145 <gets+0x49>
    cc = read(0, &c, 1);
 117:	83 ec 04             	sub    $0x4,%esp
 11a:	6a 01                	push   $0x1
 11c:	8d 45 e7             	lea    -0x19(%ebp),%eax
 11f:	50                   	push   %eax
 120:	6a 00                	push   $0x0
 122:	e8 ec 00 00 00       	call   213 <read>
    if(cc < 1)
 127:	83 c4 10             	add    $0x10,%esp
 12a:	85 c0                	test   %eax,%eax
 12c:	7e 17                	jle    145 <gets+0x49>
      break;
    buf[i++] = c;
 12e:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 132:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 135:	3c 0a                	cmp    $0xa,%al
 137:	0f 94 c2             	sete   %dl
 13a:	3c 0d                	cmp    $0xd,%al
 13c:	0f 94 c0             	sete   %al
 13f:	08 c2                	or     %al,%dl
 141:	74 ca                	je     10d <gets+0x11>
    buf[i++] = c;
 143:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 145:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 149:	89 f8                	mov    %edi,%eax
 14b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 14e:	5b                   	pop    %ebx
 14f:	5e                   	pop    %esi
 150:	5f                   	pop    %edi
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    

00000153 <stat>:

int
stat(const char *n, struct stat *st)
{
 153:	55                   	push   %ebp
 154:	89 e5                	mov    %esp,%ebp
 156:	56                   	push   %esi
 157:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 158:	83 ec 08             	sub    $0x8,%esp
 15b:	6a 00                	push   $0x0
 15d:	ff 75 08             	push   0x8(%ebp)
 160:	e8 d6 00 00 00       	call   23b <open>
  if(fd < 0)
 165:	83 c4 10             	add    $0x10,%esp
 168:	85 c0                	test   %eax,%eax
 16a:	78 24                	js     190 <stat+0x3d>
 16c:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 16e:	83 ec 08             	sub    $0x8,%esp
 171:	ff 75 0c             	push   0xc(%ebp)
 174:	50                   	push   %eax
 175:	e8 d9 00 00 00       	call   253 <fstat>
 17a:	89 c6                	mov    %eax,%esi
  close(fd);
 17c:	89 1c 24             	mov    %ebx,(%esp)
 17f:	e8 9f 00 00 00       	call   223 <close>
  return r;
 184:	83 c4 10             	add    $0x10,%esp
}
 187:	89 f0                	mov    %esi,%eax
 189:	8d 65 f8             	lea    -0x8(%ebp),%esp
 18c:	5b                   	pop    %ebx
 18d:	5e                   	pop    %esi
 18e:	5d                   	pop    %ebp
 18f:	c3                   	ret    
    return -1;
 190:	be ff ff ff ff       	mov    $0xffffffff,%esi
 195:	eb f0                	jmp    187 <stat+0x34>

00000197 <atoi>:

int
atoi(const char *s)
{
 197:	55                   	push   %ebp
 198:	89 e5                	mov    %esp,%ebp
 19a:	53                   	push   %ebx
 19b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 19e:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1a3:	eb 10                	jmp    1b5 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 1a5:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 1a8:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 1ab:	83 c1 01             	add    $0x1,%ecx
 1ae:	0f be c0             	movsbl %al,%eax
 1b1:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
 1b5:	0f b6 01             	movzbl (%ecx),%eax
 1b8:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1bb:	80 fb 09             	cmp    $0x9,%bl
 1be:	76 e5                	jbe    1a5 <atoi+0xe>
  return n;
}
 1c0:	89 d0                	mov    %edx,%eax
 1c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1c5:	c9                   	leave  
 1c6:	c3                   	ret    

000001c7 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1c7:	55                   	push   %ebp
 1c8:	89 e5                	mov    %esp,%ebp
 1ca:	56                   	push   %esi
 1cb:	53                   	push   %ebx
 1cc:	8b 75 08             	mov    0x8(%ebp),%esi
 1cf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1d2:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 1d5:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 1d7:	eb 0d                	jmp    1e6 <memmove+0x1f>
    *dst++ = *src++;
 1d9:	0f b6 01             	movzbl (%ecx),%eax
 1dc:	88 02                	mov    %al,(%edx)
 1de:	8d 49 01             	lea    0x1(%ecx),%ecx
 1e1:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 1e4:	89 d8                	mov    %ebx,%eax
 1e6:	8d 58 ff             	lea    -0x1(%eax),%ebx
 1e9:	85 c0                	test   %eax,%eax
 1eb:	7f ec                	jg     1d9 <memmove+0x12>
  return vdst;
}
 1ed:	89 f0                	mov    %esi,%eax
 1ef:	5b                   	pop    %ebx
 1f0:	5e                   	pop    %esi
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    

000001f3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1f3:	b8 01 00 00 00       	mov    $0x1,%eax
 1f8:	cd 40                	int    $0x40
 1fa:	c3                   	ret    

000001fb <exit>:
SYSCALL(exit)
 1fb:	b8 02 00 00 00       	mov    $0x2,%eax
 200:	cd 40                	int    $0x40
 202:	c3                   	ret    

00000203 <wait>:
SYSCALL(wait)
 203:	b8 03 00 00 00       	mov    $0x3,%eax
 208:	cd 40                	int    $0x40
 20a:	c3                   	ret    

0000020b <pipe>:
SYSCALL(pipe)
 20b:	b8 04 00 00 00       	mov    $0x4,%eax
 210:	cd 40                	int    $0x40
 212:	c3                   	ret    

00000213 <read>:
SYSCALL(read)
 213:	b8 05 00 00 00       	mov    $0x5,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <write>:
SYSCALL(write)
 21b:	b8 10 00 00 00       	mov    $0x10,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <close>:
SYSCALL(close)
 223:	b8 15 00 00 00       	mov    $0x15,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <kill>:
SYSCALL(kill)
 22b:	b8 06 00 00 00       	mov    $0x6,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <exec>:
SYSCALL(exec)
 233:	b8 07 00 00 00       	mov    $0x7,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <open>:
SYSCALL(open)
 23b:	b8 0f 00 00 00       	mov    $0xf,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <mknod>:
SYSCALL(mknod)
 243:	b8 11 00 00 00       	mov    $0x11,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <unlink>:
SYSCALL(unlink)
 24b:	b8 12 00 00 00       	mov    $0x12,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <fstat>:
SYSCALL(fstat)
 253:	b8 08 00 00 00       	mov    $0x8,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <link>:
SYSCALL(link)
 25b:	b8 13 00 00 00       	mov    $0x13,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <mkdir>:
SYSCALL(mkdir)
 263:	b8 14 00 00 00       	mov    $0x14,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <chdir>:
SYSCALL(chdir)
 26b:	b8 09 00 00 00       	mov    $0x9,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <dup>:
SYSCALL(dup)
 273:	b8 0a 00 00 00       	mov    $0xa,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <getpid>:
SYSCALL(getpid)
 27b:	b8 0b 00 00 00       	mov    $0xb,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <sbrk>:
SYSCALL(sbrk)
 283:	b8 0c 00 00 00       	mov    $0xc,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <sleep>:
SYSCALL(sleep)
 28b:	b8 0d 00 00 00       	mov    $0xd,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <uptime>:
SYSCALL(uptime)
 293:	b8 0e 00 00 00       	mov    $0xe,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <clone>:
SYSCALL(clone)
 29b:	b8 16 00 00 00       	mov    $0x16,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <join>:
SYSCALL(join)
 2a3:	b8 17 00 00 00       	mov    $0x17,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2ab:	55                   	push   %ebp
 2ac:	89 e5                	mov    %esp,%ebp
 2ae:	83 ec 1c             	sub    $0x1c,%esp
 2b1:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2b4:	6a 01                	push   $0x1
 2b6:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2b9:	52                   	push   %edx
 2ba:	50                   	push   %eax
 2bb:	e8 5b ff ff ff       	call   21b <write>
}
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	c9                   	leave  
 2c4:	c3                   	ret    

000002c5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2c5:	55                   	push   %ebp
 2c6:	89 e5                	mov    %esp,%ebp
 2c8:	57                   	push   %edi
 2c9:	56                   	push   %esi
 2ca:	53                   	push   %ebx
 2cb:	83 ec 2c             	sub    $0x2c,%esp
 2ce:	89 45 d0             	mov    %eax,-0x30(%ebp)
 2d1:	89 d0                	mov    %edx,%eax
 2d3:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2d9:	0f 95 c1             	setne  %cl
 2dc:	c1 ea 1f             	shr    $0x1f,%edx
 2df:	84 d1                	test   %dl,%cl
 2e1:	74 44                	je     327 <printint+0x62>
    neg = 1;
    x = -xx;
 2e3:	f7 d8                	neg    %eax
 2e5:	89 c1                	mov    %eax,%ecx
    neg = 1;
 2e7:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2ee:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 2f3:	89 c8                	mov    %ecx,%eax
 2f5:	ba 00 00 00 00       	mov    $0x0,%edx
 2fa:	f7 f6                	div    %esi
 2fc:	89 df                	mov    %ebx,%edi
 2fe:	83 c3 01             	add    $0x1,%ebx
 301:	0f b6 92 88 06 00 00 	movzbl 0x688(%edx),%edx
 308:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 30c:	89 ca                	mov    %ecx,%edx
 30e:	89 c1                	mov    %eax,%ecx
 310:	39 d6                	cmp    %edx,%esi
 312:	76 df                	jbe    2f3 <printint+0x2e>
  if(neg)
 314:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 318:	74 31                	je     34b <printint+0x86>
    buf[i++] = '-';
 31a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 31f:	8d 5f 02             	lea    0x2(%edi),%ebx
 322:	8b 75 d0             	mov    -0x30(%ebp),%esi
 325:	eb 17                	jmp    33e <printint+0x79>
    x = xx;
 327:	89 c1                	mov    %eax,%ecx
  neg = 0;
 329:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 330:	eb bc                	jmp    2ee <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
 332:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 337:	89 f0                	mov    %esi,%eax
 339:	e8 6d ff ff ff       	call   2ab <putc>
  while(--i >= 0)
 33e:	83 eb 01             	sub    $0x1,%ebx
 341:	79 ef                	jns    332 <printint+0x6d>
}
 343:	83 c4 2c             	add    $0x2c,%esp
 346:	5b                   	pop    %ebx
 347:	5e                   	pop    %esi
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    
 34b:	8b 75 d0             	mov    -0x30(%ebp),%esi
 34e:	eb ee                	jmp    33e <printint+0x79>

00000350 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 359:	8d 45 10             	lea    0x10(%ebp),%eax
 35c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 35f:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 364:	bb 00 00 00 00       	mov    $0x0,%ebx
 369:	eb 14                	jmp    37f <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 36b:	89 fa                	mov    %edi,%edx
 36d:	8b 45 08             	mov    0x8(%ebp),%eax
 370:	e8 36 ff ff ff       	call   2ab <putc>
 375:	eb 05                	jmp    37c <printf+0x2c>
      }
    } else if(state == '%'){
 377:	83 fe 25             	cmp    $0x25,%esi
 37a:	74 25                	je     3a1 <printf+0x51>
  for(i = 0; fmt[i]; i++){
 37c:	83 c3 01             	add    $0x1,%ebx
 37f:	8b 45 0c             	mov    0xc(%ebp),%eax
 382:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 386:	84 c0                	test   %al,%al
 388:	0f 84 20 01 00 00    	je     4ae <printf+0x15e>
    c = fmt[i] & 0xff;
 38e:	0f be f8             	movsbl %al,%edi
 391:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 394:	85 f6                	test   %esi,%esi
 396:	75 df                	jne    377 <printf+0x27>
      if(c == '%'){
 398:	83 f8 25             	cmp    $0x25,%eax
 39b:	75 ce                	jne    36b <printf+0x1b>
        state = '%';
 39d:	89 c6                	mov    %eax,%esi
 39f:	eb db                	jmp    37c <printf+0x2c>
      if(c == 'd'){
 3a1:	83 f8 25             	cmp    $0x25,%eax
 3a4:	0f 84 cf 00 00 00    	je     479 <printf+0x129>
 3aa:	0f 8c dd 00 00 00    	jl     48d <printf+0x13d>
 3b0:	83 f8 78             	cmp    $0x78,%eax
 3b3:	0f 8f d4 00 00 00    	jg     48d <printf+0x13d>
 3b9:	83 f8 63             	cmp    $0x63,%eax
 3bc:	0f 8c cb 00 00 00    	jl     48d <printf+0x13d>
 3c2:	83 e8 63             	sub    $0x63,%eax
 3c5:	83 f8 15             	cmp    $0x15,%eax
 3c8:	0f 87 bf 00 00 00    	ja     48d <printf+0x13d>
 3ce:	ff 24 85 30 06 00 00 	jmp    *0x630(,%eax,4)
        printint(fd, *ap, 10, 1);
 3d5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3d8:	8b 17                	mov    (%edi),%edx
 3da:	83 ec 0c             	sub    $0xc,%esp
 3dd:	6a 01                	push   $0x1
 3df:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3e4:	8b 45 08             	mov    0x8(%ebp),%eax
 3e7:	e8 d9 fe ff ff       	call   2c5 <printint>
        ap++;
 3ec:	83 c7 04             	add    $0x4,%edi
 3ef:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3f2:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3f5:	be 00 00 00 00       	mov    $0x0,%esi
 3fa:	eb 80                	jmp    37c <printf+0x2c>
        printint(fd, *ap, 16, 0);
 3fc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3ff:	8b 17                	mov    (%edi),%edx
 401:	83 ec 0c             	sub    $0xc,%esp
 404:	6a 00                	push   $0x0
 406:	b9 10 00 00 00       	mov    $0x10,%ecx
 40b:	8b 45 08             	mov    0x8(%ebp),%eax
 40e:	e8 b2 fe ff ff       	call   2c5 <printint>
        ap++;
 413:	83 c7 04             	add    $0x4,%edi
 416:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 419:	83 c4 10             	add    $0x10,%esp
      state = 0;
 41c:	be 00 00 00 00       	mov    $0x0,%esi
 421:	e9 56 ff ff ff       	jmp    37c <printf+0x2c>
        s = (char*)*ap;
 426:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 429:	8b 30                	mov    (%eax),%esi
        ap++;
 42b:	83 c0 04             	add    $0x4,%eax
 42e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 431:	85 f6                	test   %esi,%esi
 433:	75 15                	jne    44a <printf+0xfa>
          s = "(null)";
 435:	be 27 06 00 00       	mov    $0x627,%esi
 43a:	eb 0e                	jmp    44a <printf+0xfa>
          putc(fd, *s);
 43c:	0f be d2             	movsbl %dl,%edx
 43f:	8b 45 08             	mov    0x8(%ebp),%eax
 442:	e8 64 fe ff ff       	call   2ab <putc>
          s++;
 447:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 44a:	0f b6 16             	movzbl (%esi),%edx
 44d:	84 d2                	test   %dl,%dl
 44f:	75 eb                	jne    43c <printf+0xec>
      state = 0;
 451:	be 00 00 00 00       	mov    $0x0,%esi
 456:	e9 21 ff ff ff       	jmp    37c <printf+0x2c>
        putc(fd, *ap);
 45b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 45e:	0f be 17             	movsbl (%edi),%edx
 461:	8b 45 08             	mov    0x8(%ebp),%eax
 464:	e8 42 fe ff ff       	call   2ab <putc>
        ap++;
 469:	83 c7 04             	add    $0x4,%edi
 46c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 46f:	be 00 00 00 00       	mov    $0x0,%esi
 474:	e9 03 ff ff ff       	jmp    37c <printf+0x2c>
        putc(fd, c);
 479:	89 fa                	mov    %edi,%edx
 47b:	8b 45 08             	mov    0x8(%ebp),%eax
 47e:	e8 28 fe ff ff       	call   2ab <putc>
      state = 0;
 483:	be 00 00 00 00       	mov    $0x0,%esi
 488:	e9 ef fe ff ff       	jmp    37c <printf+0x2c>
        putc(fd, '%');
 48d:	ba 25 00 00 00       	mov    $0x25,%edx
 492:	8b 45 08             	mov    0x8(%ebp),%eax
 495:	e8 11 fe ff ff       	call   2ab <putc>
        putc(fd, c);
 49a:	89 fa                	mov    %edi,%edx
 49c:	8b 45 08             	mov    0x8(%ebp),%eax
 49f:	e8 07 fe ff ff       	call   2ab <putc>
      state = 0;
 4a4:	be 00 00 00 00       	mov    $0x0,%esi
 4a9:	e9 ce fe ff ff       	jmp    37c <printf+0x2c>
    }
  }
}
 4ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b1:	5b                   	pop    %ebx
 4b2:	5e                   	pop    %esi
 4b3:	5f                   	pop    %edi
 4b4:	5d                   	pop    %ebp
 4b5:	c3                   	ret    

000004b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4b6:	55                   	push   %ebp
 4b7:	89 e5                	mov    %esp,%ebp
 4b9:	57                   	push   %edi
 4ba:	56                   	push   %esi
 4bb:	53                   	push   %ebx
 4bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4bf:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4c2:	a1 2c 09 00 00       	mov    0x92c,%eax
 4c7:	eb 02                	jmp    4cb <free+0x15>
 4c9:	89 d0                	mov    %edx,%eax
 4cb:	39 c8                	cmp    %ecx,%eax
 4cd:	73 04                	jae    4d3 <free+0x1d>
 4cf:	39 08                	cmp    %ecx,(%eax)
 4d1:	77 12                	ja     4e5 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d3:	8b 10                	mov    (%eax),%edx
 4d5:	39 c2                	cmp    %eax,%edx
 4d7:	77 f0                	ja     4c9 <free+0x13>
 4d9:	39 c8                	cmp    %ecx,%eax
 4db:	72 08                	jb     4e5 <free+0x2f>
 4dd:	39 ca                	cmp    %ecx,%edx
 4df:	77 04                	ja     4e5 <free+0x2f>
 4e1:	89 d0                	mov    %edx,%eax
 4e3:	eb e6                	jmp    4cb <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4e5:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4e8:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4eb:	8b 10                	mov    (%eax),%edx
 4ed:	39 d7                	cmp    %edx,%edi
 4ef:	74 19                	je     50a <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4f1:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4f4:	8b 50 04             	mov    0x4(%eax),%edx
 4f7:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4fa:	39 ce                	cmp    %ecx,%esi
 4fc:	74 1b                	je     519 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4fe:	89 08                	mov    %ecx,(%eax)
  freep = p;
 500:	a3 2c 09 00 00       	mov    %eax,0x92c
}
 505:	5b                   	pop    %ebx
 506:	5e                   	pop    %esi
 507:	5f                   	pop    %edi
 508:	5d                   	pop    %ebp
 509:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 50a:	03 72 04             	add    0x4(%edx),%esi
 50d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 510:	8b 10                	mov    (%eax),%edx
 512:	8b 12                	mov    (%edx),%edx
 514:	89 53 f8             	mov    %edx,-0x8(%ebx)
 517:	eb db                	jmp    4f4 <free+0x3e>
    p->s.size += bp->s.size;
 519:	03 53 fc             	add    -0x4(%ebx),%edx
 51c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 51f:	8b 53 f8             	mov    -0x8(%ebx),%edx
 522:	89 10                	mov    %edx,(%eax)
 524:	eb da                	jmp    500 <free+0x4a>

00000526 <morecore>:

static Header*
morecore(uint nu)
{
 526:	55                   	push   %ebp
 527:	89 e5                	mov    %esp,%ebp
 529:	53                   	push   %ebx
 52a:	83 ec 04             	sub    $0x4,%esp
 52d:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 52f:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 534:	77 05                	ja     53b <morecore+0x15>
    nu = 4096;
 536:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 53b:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 542:	83 ec 0c             	sub    $0xc,%esp
 545:	50                   	push   %eax
 546:	e8 38 fd ff ff       	call   283 <sbrk>
  if(p == (char*)-1)
 54b:	83 c4 10             	add    $0x10,%esp
 54e:	83 f8 ff             	cmp    $0xffffffff,%eax
 551:	74 1c                	je     56f <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 553:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 556:	83 c0 08             	add    $0x8,%eax
 559:	83 ec 0c             	sub    $0xc,%esp
 55c:	50                   	push   %eax
 55d:	e8 54 ff ff ff       	call   4b6 <free>
  return freep;
 562:	a1 2c 09 00 00       	mov    0x92c,%eax
 567:	83 c4 10             	add    $0x10,%esp
}
 56a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 56d:	c9                   	leave  
 56e:	c3                   	ret    
    return 0;
 56f:	b8 00 00 00 00       	mov    $0x0,%eax
 574:	eb f4                	jmp    56a <morecore+0x44>

00000576 <malloc>:

void*
malloc(uint nbytes)
{
 576:	55                   	push   %ebp
 577:	89 e5                	mov    %esp,%ebp
 579:	53                   	push   %ebx
 57a:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 57d:	8b 45 08             	mov    0x8(%ebp),%eax
 580:	8d 58 07             	lea    0x7(%eax),%ebx
 583:	c1 eb 03             	shr    $0x3,%ebx
 586:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 589:	8b 0d 2c 09 00 00    	mov    0x92c,%ecx
 58f:	85 c9                	test   %ecx,%ecx
 591:	74 04                	je     597 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 593:	8b 01                	mov    (%ecx),%eax
 595:	eb 4a                	jmp    5e1 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
 597:	c7 05 2c 09 00 00 30 	movl   $0x930,0x92c
 59e:	09 00 00 
 5a1:	c7 05 30 09 00 00 30 	movl   $0x930,0x930
 5a8:	09 00 00 
    base.s.size = 0;
 5ab:	c7 05 34 09 00 00 00 	movl   $0x0,0x934
 5b2:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5b5:	b9 30 09 00 00       	mov    $0x930,%ecx
 5ba:	eb d7                	jmp    593 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5bc:	74 19                	je     5d7 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5be:	29 da                	sub    %ebx,%edx
 5c0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 5c3:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 5c6:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5c9:	89 0d 2c 09 00 00    	mov    %ecx,0x92c
      return (void*)(p + 1);
 5cf:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5d5:	c9                   	leave  
 5d6:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 5d7:	8b 10                	mov    (%eax),%edx
 5d9:	89 11                	mov    %edx,(%ecx)
 5db:	eb ec                	jmp    5c9 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5dd:	89 c1                	mov    %eax,%ecx
 5df:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 5e1:	8b 50 04             	mov    0x4(%eax),%edx
 5e4:	39 da                	cmp    %ebx,%edx
 5e6:	73 d4                	jae    5bc <malloc+0x46>
    if(p == freep)
 5e8:	39 05 2c 09 00 00    	cmp    %eax,0x92c
 5ee:	75 ed                	jne    5dd <malloc+0x67>
      if((p = morecore(nunits)) == 0)
 5f0:	89 d8                	mov    %ebx,%eax
 5f2:	e8 2f ff ff ff       	call   526 <morecore>
 5f7:	85 c0                	test   %eax,%eax
 5f9:	75 e2                	jne    5dd <malloc+0x67>
 5fb:	eb d5                	jmp    5d2 <malloc+0x5c>
