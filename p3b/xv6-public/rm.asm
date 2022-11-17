
_rm:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 39                	mov    (%ecx),%edi
  16:	8b 41 04             	mov    0x4(%ecx),%eax
  19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int i;

  if(argc < 2){
  1c:	83 ff 01             	cmp    $0x1,%edi
  1f:	7e 07                	jle    28 <main+0x28>
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  21:	bb 01 00 00 00       	mov    $0x1,%ebx
  26:	eb 17                	jmp    3f <main+0x3f>
    printf(2, "Usage: rm files...\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 14 06 00 00       	push   $0x614
  30:	6a 02                	push   $0x2
  32:	e8 30 03 00 00       	call   367 <printf>
    exit();
  37:	e8 d6 01 00 00       	call   212 <exit>
  for(i = 1; i < argc; i++){
  3c:	83 c3 01             	add    $0x1,%ebx
  3f:	39 fb                	cmp    %edi,%ebx
  41:	7d 2b                	jge    6e <main+0x6e>
    if(unlink(argv[i]) < 0){
  43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  46:	8d 34 98             	lea    (%eax,%ebx,4),%esi
  49:	83 ec 0c             	sub    $0xc,%esp
  4c:	ff 36                	push   (%esi)
  4e:	e8 0f 02 00 00       	call   262 <unlink>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	79 e2                	jns    3c <main+0x3c>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  5a:	83 ec 04             	sub    $0x4,%esp
  5d:	ff 36                	push   (%esi)
  5f:	68 28 06 00 00       	push   $0x628
  64:	6a 02                	push   $0x2
  66:	e8 fc 02 00 00       	call   367 <printf>
      break;
  6b:	83 c4 10             	add    $0x10,%esp
    }
  }

  exit();
  6e:	e8 9f 01 00 00       	call   212 <exit>

00000073 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  73:	55                   	push   %ebp
  74:	89 e5                	mov    %esp,%ebp
  76:	56                   	push   %esi
  77:	53                   	push   %ebx
  78:	8b 75 08             	mov    0x8(%ebp),%esi
  7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7e:	89 f0                	mov    %esi,%eax
  80:	89 d1                	mov    %edx,%ecx
  82:	83 c2 01             	add    $0x1,%edx
  85:	89 c3                	mov    %eax,%ebx
  87:	83 c0 01             	add    $0x1,%eax
  8a:	0f b6 09             	movzbl (%ecx),%ecx
  8d:	88 0b                	mov    %cl,(%ebx)
  8f:	84 c9                	test   %cl,%cl
  91:	75 ed                	jne    80 <strcpy+0xd>
    ;
  return os;
}
  93:	89 f0                	mov    %esi,%eax
  95:	5b                   	pop    %ebx
  96:	5e                   	pop    %esi
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    

00000099 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  99:	55                   	push   %ebp
  9a:	89 e5                	mov    %esp,%ebp
  9c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  a2:	eb 06                	jmp    aa <strcmp+0x11>
    p++, q++;
  a4:	83 c1 01             	add    $0x1,%ecx
  a7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  aa:	0f b6 01             	movzbl (%ecx),%eax
  ad:	84 c0                	test   %al,%al
  af:	74 04                	je     b5 <strcmp+0x1c>
  b1:	3a 02                	cmp    (%edx),%al
  b3:	74 ef                	je     a4 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
  b5:	0f b6 c0             	movzbl %al,%eax
  b8:	0f b6 12             	movzbl (%edx),%edx
  bb:	29 d0                	sub    %edx,%eax
}
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    

000000bf <strlen>:

uint
strlen(const char *s)
{
  bf:	55                   	push   %ebp
  c0:	89 e5                	mov    %esp,%ebp
  c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  c5:	b8 00 00 00 00       	mov    $0x0,%eax
  ca:	eb 03                	jmp    cf <strlen+0x10>
  cc:	83 c0 01             	add    $0x1,%eax
  cf:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  d3:	75 f7                	jne    cc <strlen+0xd>
    ;
  return n;
}
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    

000000d7 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d7:	55                   	push   %ebp
  d8:	89 e5                	mov    %esp,%ebp
  da:	57                   	push   %edi
  db:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  de:	89 d7                	mov    %edx,%edi
  e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  e6:	fc                   	cld    
  e7:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e9:	89 d0                	mov    %edx,%eax
  eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  ee:	c9                   	leave  
  ef:	c3                   	ret    

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  fa:	eb 03                	jmp    ff <strchr+0xf>
  fc:	83 c0 01             	add    $0x1,%eax
  ff:	0f b6 10             	movzbl (%eax),%edx
 102:	84 d2                	test   %dl,%dl
 104:	74 06                	je     10c <strchr+0x1c>
    if(*s == c)
 106:	38 ca                	cmp    %cl,%dl
 108:	75 f2                	jne    fc <strchr+0xc>
 10a:	eb 05                	jmp    111 <strchr+0x21>
      return (char*)s;
  return 0;
 10c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    

00000113 <gets>:

char*
gets(char *buf, int max)
{
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp
 116:	57                   	push   %edi
 117:	56                   	push   %esi
 118:	53                   	push   %ebx
 119:	83 ec 1c             	sub    $0x1c,%esp
 11c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11f:	bb 00 00 00 00       	mov    $0x0,%ebx
 124:	89 de                	mov    %ebx,%esi
 126:	83 c3 01             	add    $0x1,%ebx
 129:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 12c:	7d 2e                	jge    15c <gets+0x49>
    cc = read(0, &c, 1);
 12e:	83 ec 04             	sub    $0x4,%esp
 131:	6a 01                	push   $0x1
 133:	8d 45 e7             	lea    -0x19(%ebp),%eax
 136:	50                   	push   %eax
 137:	6a 00                	push   $0x0
 139:	e8 ec 00 00 00       	call   22a <read>
    if(cc < 1)
 13e:	83 c4 10             	add    $0x10,%esp
 141:	85 c0                	test   %eax,%eax
 143:	7e 17                	jle    15c <gets+0x49>
      break;
    buf[i++] = c;
 145:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 149:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 14c:	3c 0a                	cmp    $0xa,%al
 14e:	0f 94 c2             	sete   %dl
 151:	3c 0d                	cmp    $0xd,%al
 153:	0f 94 c0             	sete   %al
 156:	08 c2                	or     %al,%dl
 158:	74 ca                	je     124 <gets+0x11>
    buf[i++] = c;
 15a:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 15c:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 160:	89 f8                	mov    %edi,%eax
 162:	8d 65 f4             	lea    -0xc(%ebp),%esp
 165:	5b                   	pop    %ebx
 166:	5e                   	pop    %esi
 167:	5f                   	pop    %edi
 168:	5d                   	pop    %ebp
 169:	c3                   	ret    

0000016a <stat>:

int
stat(const char *n, struct stat *st)
{
 16a:	55                   	push   %ebp
 16b:	89 e5                	mov    %esp,%ebp
 16d:	56                   	push   %esi
 16e:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 16f:	83 ec 08             	sub    $0x8,%esp
 172:	6a 00                	push   $0x0
 174:	ff 75 08             	push   0x8(%ebp)
 177:	e8 d6 00 00 00       	call   252 <open>
  if(fd < 0)
 17c:	83 c4 10             	add    $0x10,%esp
 17f:	85 c0                	test   %eax,%eax
 181:	78 24                	js     1a7 <stat+0x3d>
 183:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 185:	83 ec 08             	sub    $0x8,%esp
 188:	ff 75 0c             	push   0xc(%ebp)
 18b:	50                   	push   %eax
 18c:	e8 d9 00 00 00       	call   26a <fstat>
 191:	89 c6                	mov    %eax,%esi
  close(fd);
 193:	89 1c 24             	mov    %ebx,(%esp)
 196:	e8 9f 00 00 00       	call   23a <close>
  return r;
 19b:	83 c4 10             	add    $0x10,%esp
}
 19e:	89 f0                	mov    %esi,%eax
 1a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a3:	5b                   	pop    %ebx
 1a4:	5e                   	pop    %esi
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
    return -1;
 1a7:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1ac:	eb f0                	jmp    19e <stat+0x34>

000001ae <atoi>:

int
atoi(const char *s)
{
 1ae:	55                   	push   %ebp
 1af:	89 e5                	mov    %esp,%ebp
 1b1:	53                   	push   %ebx
 1b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 1b5:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1ba:	eb 10                	jmp    1cc <atoi+0x1e>
    n = n*10 + *s++ - '0';
 1bc:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 1bf:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 1c2:	83 c1 01             	add    $0x1,%ecx
 1c5:	0f be c0             	movsbl %al,%eax
 1c8:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
 1cc:	0f b6 01             	movzbl (%ecx),%eax
 1cf:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1d2:	80 fb 09             	cmp    $0x9,%bl
 1d5:	76 e5                	jbe    1bc <atoi+0xe>
  return n;
}
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1dc:	c9                   	leave  
 1dd:	c3                   	ret    

000001de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1de:	55                   	push   %ebp
 1df:	89 e5                	mov    %esp,%ebp
 1e1:	56                   	push   %esi
 1e2:	53                   	push   %ebx
 1e3:	8b 75 08             	mov    0x8(%ebp),%esi
 1e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1e9:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 1ec:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 1ee:	eb 0d                	jmp    1fd <memmove+0x1f>
    *dst++ = *src++;
 1f0:	0f b6 01             	movzbl (%ecx),%eax
 1f3:	88 02                	mov    %al,(%edx)
 1f5:	8d 49 01             	lea    0x1(%ecx),%ecx
 1f8:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 1fb:	89 d8                	mov    %ebx,%eax
 1fd:	8d 58 ff             	lea    -0x1(%eax),%ebx
 200:	85 c0                	test   %eax,%eax
 202:	7f ec                	jg     1f0 <memmove+0x12>
  return vdst;
}
 204:	89 f0                	mov    %esi,%eax
 206:	5b                   	pop    %ebx
 207:	5e                   	pop    %esi
 208:	5d                   	pop    %ebp
 209:	c3                   	ret    

0000020a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 20a:	b8 01 00 00 00       	mov    $0x1,%eax
 20f:	cd 40                	int    $0x40
 211:	c3                   	ret    

00000212 <exit>:
SYSCALL(exit)
 212:	b8 02 00 00 00       	mov    $0x2,%eax
 217:	cd 40                	int    $0x40
 219:	c3                   	ret    

0000021a <wait>:
SYSCALL(wait)
 21a:	b8 03 00 00 00       	mov    $0x3,%eax
 21f:	cd 40                	int    $0x40
 221:	c3                   	ret    

00000222 <pipe>:
SYSCALL(pipe)
 222:	b8 04 00 00 00       	mov    $0x4,%eax
 227:	cd 40                	int    $0x40
 229:	c3                   	ret    

0000022a <read>:
SYSCALL(read)
 22a:	b8 05 00 00 00       	mov    $0x5,%eax
 22f:	cd 40                	int    $0x40
 231:	c3                   	ret    

00000232 <write>:
SYSCALL(write)
 232:	b8 10 00 00 00       	mov    $0x10,%eax
 237:	cd 40                	int    $0x40
 239:	c3                   	ret    

0000023a <close>:
SYSCALL(close)
 23a:	b8 15 00 00 00       	mov    $0x15,%eax
 23f:	cd 40                	int    $0x40
 241:	c3                   	ret    

00000242 <kill>:
SYSCALL(kill)
 242:	b8 06 00 00 00       	mov    $0x6,%eax
 247:	cd 40                	int    $0x40
 249:	c3                   	ret    

0000024a <exec>:
SYSCALL(exec)
 24a:	b8 07 00 00 00       	mov    $0x7,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <open>:
SYSCALL(open)
 252:	b8 0f 00 00 00       	mov    $0xf,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <mknod>:
SYSCALL(mknod)
 25a:	b8 11 00 00 00       	mov    $0x11,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <unlink>:
SYSCALL(unlink)
 262:	b8 12 00 00 00       	mov    $0x12,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <fstat>:
SYSCALL(fstat)
 26a:	b8 08 00 00 00       	mov    $0x8,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <link>:
SYSCALL(link)
 272:	b8 13 00 00 00       	mov    $0x13,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <mkdir>:
SYSCALL(mkdir)
 27a:	b8 14 00 00 00       	mov    $0x14,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <chdir>:
SYSCALL(chdir)
 282:	b8 09 00 00 00       	mov    $0x9,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <dup>:
SYSCALL(dup)
 28a:	b8 0a 00 00 00       	mov    $0xa,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <getpid>:
SYSCALL(getpid)
 292:	b8 0b 00 00 00       	mov    $0xb,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <sbrk>:
SYSCALL(sbrk)
 29a:	b8 0c 00 00 00       	mov    $0xc,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <sleep>:
SYSCALL(sleep)
 2a2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <uptime>:
SYSCALL(uptime)
 2aa:	b8 0e 00 00 00       	mov    $0xe,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <clone>:
SYSCALL(clone)
 2b2:	b8 16 00 00 00       	mov    $0x16,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <join>:
SYSCALL(join)
 2ba:	b8 17 00 00 00       	mov    $0x17,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2c2:	55                   	push   %ebp
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	83 ec 1c             	sub    $0x1c,%esp
 2c8:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2cb:	6a 01                	push   $0x1
 2cd:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2d0:	52                   	push   %edx
 2d1:	50                   	push   %eax
 2d2:	e8 5b ff ff ff       	call   232 <write>
}
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	c9                   	leave  
 2db:	c3                   	ret    

000002dc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2dc:	55                   	push   %ebp
 2dd:	89 e5                	mov    %esp,%ebp
 2df:	57                   	push   %edi
 2e0:	56                   	push   %esi
 2e1:	53                   	push   %ebx
 2e2:	83 ec 2c             	sub    $0x2c,%esp
 2e5:	89 45 d0             	mov    %eax,-0x30(%ebp)
 2e8:	89 d0                	mov    %edx,%eax
 2ea:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2f0:	0f 95 c1             	setne  %cl
 2f3:	c1 ea 1f             	shr    $0x1f,%edx
 2f6:	84 d1                	test   %dl,%cl
 2f8:	74 44                	je     33e <printint+0x62>
    neg = 1;
    x = -xx;
 2fa:	f7 d8                	neg    %eax
 2fc:	89 c1                	mov    %eax,%ecx
    neg = 1;
 2fe:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 305:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 30a:	89 c8                	mov    %ecx,%eax
 30c:	ba 00 00 00 00       	mov    $0x0,%edx
 311:	f7 f6                	div    %esi
 313:	89 df                	mov    %ebx,%edi
 315:	83 c3 01             	add    $0x1,%ebx
 318:	0f b6 92 a0 06 00 00 	movzbl 0x6a0(%edx),%edx
 31f:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 323:	89 ca                	mov    %ecx,%edx
 325:	89 c1                	mov    %eax,%ecx
 327:	39 d6                	cmp    %edx,%esi
 329:	76 df                	jbe    30a <printint+0x2e>
  if(neg)
 32b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 32f:	74 31                	je     362 <printint+0x86>
    buf[i++] = '-';
 331:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 336:	8d 5f 02             	lea    0x2(%edi),%ebx
 339:	8b 75 d0             	mov    -0x30(%ebp),%esi
 33c:	eb 17                	jmp    355 <printint+0x79>
    x = xx;
 33e:	89 c1                	mov    %eax,%ecx
  neg = 0;
 340:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 347:	eb bc                	jmp    305 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
 349:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 34e:	89 f0                	mov    %esi,%eax
 350:	e8 6d ff ff ff       	call   2c2 <putc>
  while(--i >= 0)
 355:	83 eb 01             	sub    $0x1,%ebx
 358:	79 ef                	jns    349 <printint+0x6d>
}
 35a:	83 c4 2c             	add    $0x2c,%esp
 35d:	5b                   	pop    %ebx
 35e:	5e                   	pop    %esi
 35f:	5f                   	pop    %edi
 360:	5d                   	pop    %ebp
 361:	c3                   	ret    
 362:	8b 75 d0             	mov    -0x30(%ebp),%esi
 365:	eb ee                	jmp    355 <printint+0x79>

00000367 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 367:	55                   	push   %ebp
 368:	89 e5                	mov    %esp,%ebp
 36a:	57                   	push   %edi
 36b:	56                   	push   %esi
 36c:	53                   	push   %ebx
 36d:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 370:	8d 45 10             	lea    0x10(%ebp),%eax
 373:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 376:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 37b:	bb 00 00 00 00       	mov    $0x0,%ebx
 380:	eb 14                	jmp    396 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 382:	89 fa                	mov    %edi,%edx
 384:	8b 45 08             	mov    0x8(%ebp),%eax
 387:	e8 36 ff ff ff       	call   2c2 <putc>
 38c:	eb 05                	jmp    393 <printf+0x2c>
      }
    } else if(state == '%'){
 38e:	83 fe 25             	cmp    $0x25,%esi
 391:	74 25                	je     3b8 <printf+0x51>
  for(i = 0; fmt[i]; i++){
 393:	83 c3 01             	add    $0x1,%ebx
 396:	8b 45 0c             	mov    0xc(%ebp),%eax
 399:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 39d:	84 c0                	test   %al,%al
 39f:	0f 84 20 01 00 00    	je     4c5 <printf+0x15e>
    c = fmt[i] & 0xff;
 3a5:	0f be f8             	movsbl %al,%edi
 3a8:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 3ab:	85 f6                	test   %esi,%esi
 3ad:	75 df                	jne    38e <printf+0x27>
      if(c == '%'){
 3af:	83 f8 25             	cmp    $0x25,%eax
 3b2:	75 ce                	jne    382 <printf+0x1b>
        state = '%';
 3b4:	89 c6                	mov    %eax,%esi
 3b6:	eb db                	jmp    393 <printf+0x2c>
      if(c == 'd'){
 3b8:	83 f8 25             	cmp    $0x25,%eax
 3bb:	0f 84 cf 00 00 00    	je     490 <printf+0x129>
 3c1:	0f 8c dd 00 00 00    	jl     4a4 <printf+0x13d>
 3c7:	83 f8 78             	cmp    $0x78,%eax
 3ca:	0f 8f d4 00 00 00    	jg     4a4 <printf+0x13d>
 3d0:	83 f8 63             	cmp    $0x63,%eax
 3d3:	0f 8c cb 00 00 00    	jl     4a4 <printf+0x13d>
 3d9:	83 e8 63             	sub    $0x63,%eax
 3dc:	83 f8 15             	cmp    $0x15,%eax
 3df:	0f 87 bf 00 00 00    	ja     4a4 <printf+0x13d>
 3e5:	ff 24 85 48 06 00 00 	jmp    *0x648(,%eax,4)
        printint(fd, *ap, 10, 1);
 3ec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3ef:	8b 17                	mov    (%edi),%edx
 3f1:	83 ec 0c             	sub    $0xc,%esp
 3f4:	6a 01                	push   $0x1
 3f6:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3fb:	8b 45 08             	mov    0x8(%ebp),%eax
 3fe:	e8 d9 fe ff ff       	call   2dc <printint>
        ap++;
 403:	83 c7 04             	add    $0x4,%edi
 406:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 409:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 40c:	be 00 00 00 00       	mov    $0x0,%esi
 411:	eb 80                	jmp    393 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 413:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 416:	8b 17                	mov    (%edi),%edx
 418:	83 ec 0c             	sub    $0xc,%esp
 41b:	6a 00                	push   $0x0
 41d:	b9 10 00 00 00       	mov    $0x10,%ecx
 422:	8b 45 08             	mov    0x8(%ebp),%eax
 425:	e8 b2 fe ff ff       	call   2dc <printint>
        ap++;
 42a:	83 c7 04             	add    $0x4,%edi
 42d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 430:	83 c4 10             	add    $0x10,%esp
      state = 0;
 433:	be 00 00 00 00       	mov    $0x0,%esi
 438:	e9 56 ff ff ff       	jmp    393 <printf+0x2c>
        s = (char*)*ap;
 43d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 440:	8b 30                	mov    (%eax),%esi
        ap++;
 442:	83 c0 04             	add    $0x4,%eax
 445:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 448:	85 f6                	test   %esi,%esi
 44a:	75 15                	jne    461 <printf+0xfa>
          s = "(null)";
 44c:	be 41 06 00 00       	mov    $0x641,%esi
 451:	eb 0e                	jmp    461 <printf+0xfa>
          putc(fd, *s);
 453:	0f be d2             	movsbl %dl,%edx
 456:	8b 45 08             	mov    0x8(%ebp),%eax
 459:	e8 64 fe ff ff       	call   2c2 <putc>
          s++;
 45e:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 461:	0f b6 16             	movzbl (%esi),%edx
 464:	84 d2                	test   %dl,%dl
 466:	75 eb                	jne    453 <printf+0xec>
      state = 0;
 468:	be 00 00 00 00       	mov    $0x0,%esi
 46d:	e9 21 ff ff ff       	jmp    393 <printf+0x2c>
        putc(fd, *ap);
 472:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 475:	0f be 17             	movsbl (%edi),%edx
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	e8 42 fe ff ff       	call   2c2 <putc>
        ap++;
 480:	83 c7 04             	add    $0x4,%edi
 483:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 486:	be 00 00 00 00       	mov    $0x0,%esi
 48b:	e9 03 ff ff ff       	jmp    393 <printf+0x2c>
        putc(fd, c);
 490:	89 fa                	mov    %edi,%edx
 492:	8b 45 08             	mov    0x8(%ebp),%eax
 495:	e8 28 fe ff ff       	call   2c2 <putc>
      state = 0;
 49a:	be 00 00 00 00       	mov    $0x0,%esi
 49f:	e9 ef fe ff ff       	jmp    393 <printf+0x2c>
        putc(fd, '%');
 4a4:	ba 25 00 00 00       	mov    $0x25,%edx
 4a9:	8b 45 08             	mov    0x8(%ebp),%eax
 4ac:	e8 11 fe ff ff       	call   2c2 <putc>
        putc(fd, c);
 4b1:	89 fa                	mov    %edi,%edx
 4b3:	8b 45 08             	mov    0x8(%ebp),%eax
 4b6:	e8 07 fe ff ff       	call   2c2 <putc>
      state = 0;
 4bb:	be 00 00 00 00       	mov    $0x0,%esi
 4c0:	e9 ce fe ff ff       	jmp    393 <printf+0x2c>
    }
  }
}
 4c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c8:	5b                   	pop    %ebx
 4c9:	5e                   	pop    %esi
 4ca:	5f                   	pop    %edi
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret    

000004cd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4cd:	55                   	push   %ebp
 4ce:	89 e5                	mov    %esp,%ebp
 4d0:	57                   	push   %edi
 4d1:	56                   	push   %esi
 4d2:	53                   	push   %ebx
 4d3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4d6:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d9:	a1 4c 09 00 00       	mov    0x94c,%eax
 4de:	eb 02                	jmp    4e2 <free+0x15>
 4e0:	89 d0                	mov    %edx,%eax
 4e2:	39 c8                	cmp    %ecx,%eax
 4e4:	73 04                	jae    4ea <free+0x1d>
 4e6:	39 08                	cmp    %ecx,(%eax)
 4e8:	77 12                	ja     4fc <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4ea:	8b 10                	mov    (%eax),%edx
 4ec:	39 c2                	cmp    %eax,%edx
 4ee:	77 f0                	ja     4e0 <free+0x13>
 4f0:	39 c8                	cmp    %ecx,%eax
 4f2:	72 08                	jb     4fc <free+0x2f>
 4f4:	39 ca                	cmp    %ecx,%edx
 4f6:	77 04                	ja     4fc <free+0x2f>
 4f8:	89 d0                	mov    %edx,%eax
 4fa:	eb e6                	jmp    4e2 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4fc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4ff:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 502:	8b 10                	mov    (%eax),%edx
 504:	39 d7                	cmp    %edx,%edi
 506:	74 19                	je     521 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 508:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 50b:	8b 50 04             	mov    0x4(%eax),%edx
 50e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 511:	39 ce                	cmp    %ecx,%esi
 513:	74 1b                	je     530 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 515:	89 08                	mov    %ecx,(%eax)
  freep = p;
 517:	a3 4c 09 00 00       	mov    %eax,0x94c
}
 51c:	5b                   	pop    %ebx
 51d:	5e                   	pop    %esi
 51e:	5f                   	pop    %edi
 51f:	5d                   	pop    %ebp
 520:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 521:	03 72 04             	add    0x4(%edx),%esi
 524:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 527:	8b 10                	mov    (%eax),%edx
 529:	8b 12                	mov    (%edx),%edx
 52b:	89 53 f8             	mov    %edx,-0x8(%ebx)
 52e:	eb db                	jmp    50b <free+0x3e>
    p->s.size += bp->s.size;
 530:	03 53 fc             	add    -0x4(%ebx),%edx
 533:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 536:	8b 53 f8             	mov    -0x8(%ebx),%edx
 539:	89 10                	mov    %edx,(%eax)
 53b:	eb da                	jmp    517 <free+0x4a>

0000053d <morecore>:

static Header*
morecore(uint nu)
{
 53d:	55                   	push   %ebp
 53e:	89 e5                	mov    %esp,%ebp
 540:	53                   	push   %ebx
 541:	83 ec 04             	sub    $0x4,%esp
 544:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 546:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 54b:	77 05                	ja     552 <morecore+0x15>
    nu = 4096;
 54d:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 552:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 559:	83 ec 0c             	sub    $0xc,%esp
 55c:	50                   	push   %eax
 55d:	e8 38 fd ff ff       	call   29a <sbrk>
  if(p == (char*)-1)
 562:	83 c4 10             	add    $0x10,%esp
 565:	83 f8 ff             	cmp    $0xffffffff,%eax
 568:	74 1c                	je     586 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 56a:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 56d:	83 c0 08             	add    $0x8,%eax
 570:	83 ec 0c             	sub    $0xc,%esp
 573:	50                   	push   %eax
 574:	e8 54 ff ff ff       	call   4cd <free>
  return freep;
 579:	a1 4c 09 00 00       	mov    0x94c,%eax
 57e:	83 c4 10             	add    $0x10,%esp
}
 581:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 584:	c9                   	leave  
 585:	c3                   	ret    
    return 0;
 586:	b8 00 00 00 00       	mov    $0x0,%eax
 58b:	eb f4                	jmp    581 <morecore+0x44>

0000058d <malloc>:

void*
malloc(uint nbytes)
{
 58d:	55                   	push   %ebp
 58e:	89 e5                	mov    %esp,%ebp
 590:	53                   	push   %ebx
 591:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	8d 58 07             	lea    0x7(%eax),%ebx
 59a:	c1 eb 03             	shr    $0x3,%ebx
 59d:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5a0:	8b 0d 4c 09 00 00    	mov    0x94c,%ecx
 5a6:	85 c9                	test   %ecx,%ecx
 5a8:	74 04                	je     5ae <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5aa:	8b 01                	mov    (%ecx),%eax
 5ac:	eb 4a                	jmp    5f8 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
 5ae:	c7 05 4c 09 00 00 50 	movl   $0x950,0x94c
 5b5:	09 00 00 
 5b8:	c7 05 50 09 00 00 50 	movl   $0x950,0x950
 5bf:	09 00 00 
    base.s.size = 0;
 5c2:	c7 05 54 09 00 00 00 	movl   $0x0,0x954
 5c9:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5cc:	b9 50 09 00 00       	mov    $0x950,%ecx
 5d1:	eb d7                	jmp    5aa <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5d3:	74 19                	je     5ee <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5d5:	29 da                	sub    %ebx,%edx
 5d7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 5da:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 5dd:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5e0:	89 0d 4c 09 00 00    	mov    %ecx,0x94c
      return (void*)(p + 1);
 5e6:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5ec:	c9                   	leave  
 5ed:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 5ee:	8b 10                	mov    (%eax),%edx
 5f0:	89 11                	mov    %edx,(%ecx)
 5f2:	eb ec                	jmp    5e0 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5f4:	89 c1                	mov    %eax,%ecx
 5f6:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 5f8:	8b 50 04             	mov    0x4(%eax),%edx
 5fb:	39 da                	cmp    %ebx,%edx
 5fd:	73 d4                	jae    5d3 <malloc+0x46>
    if(p == freep)
 5ff:	39 05 4c 09 00 00    	cmp    %eax,0x94c
 605:	75 ed                	jne    5f4 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
 607:	89 d8                	mov    %ebx,%eax
 609:	e8 2f ff ff ff       	call   53d <morecore>
 60e:	85 c0                	test   %eax,%eax
 610:	75 e2                	jne    5f4 <malloc+0x67>
 612:	eb d5                	jmp    5e9 <malloc+0x5c>
