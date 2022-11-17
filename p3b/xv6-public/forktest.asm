
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 10             	sub    $0x10,%esp
   7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   a:	53                   	push   %ebx
   b:	e8 25 01 00 00       	call   135 <strlen>
  10:	83 c4 0c             	add    $0xc,%esp
  13:	50                   	push   %eax
  14:	53                   	push   %ebx
  15:	ff 75 08             	push   0x8(%ebp)
  18:	e8 8b 02 00 00       	call   2a8 <write>
}
  1d:	83 c4 10             	add    $0x10,%esp
  20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  23:	c9                   	leave  
  24:	c3                   	ret    

00000025 <forktest>:

void
forktest(void)
{
  25:	55                   	push   %ebp
  26:	89 e5                	mov    %esp,%ebp
  28:	53                   	push   %ebx
  29:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
  2c:	68 80 04 00 00       	push   $0x480
  31:	6a 01                	push   $0x1
  33:	e8 c8 ff ff ff       	call   0 <printf>

  for(n=0; n<N; n++){
  38:	83 c4 10             	add    $0x10,%esp
  3b:	bb 00 00 00 00       	mov    $0x0,%ebx
  40:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
  46:	7f 15                	jg     5d <forktest+0x38>
    pid = fork();
  48:	e8 33 02 00 00       	call   280 <fork>
    if(pid < 0)
  4d:	85 c0                	test   %eax,%eax
  4f:	78 0c                	js     5d <forktest+0x38>
      break;
    if(pid == 0)
  51:	74 05                	je     58 <forktest+0x33>
  for(n=0; n<N; n++){
  53:	83 c3 01             	add    $0x1,%ebx
  56:	eb e8                	jmp    40 <forktest+0x1b>
      exit();
  58:	e8 2b 02 00 00       	call   288 <exit>
  }

  if(n == N){
  5d:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  63:	74 12                	je     77 <forktest+0x52>
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  65:	85 db                	test   %ebx,%ebx
  67:	7e 3b                	jle    a4 <forktest+0x7f>
    if(wait() < 0){
  69:	e8 22 02 00 00       	call   290 <wait>
  6e:	85 c0                	test   %eax,%eax
  70:	78 1e                	js     90 <forktest+0x6b>
  for(; n > 0; n--){
  72:	83 eb 01             	sub    $0x1,%ebx
  75:	eb ee                	jmp    65 <forktest+0x40>
    printf(1, "fork claimed to work N times!\n", N);
  77:	83 ec 04             	sub    $0x4,%esp
  7a:	68 e8 03 00 00       	push   $0x3e8
  7f:	68 c0 04 00 00       	push   $0x4c0
  84:	6a 01                	push   $0x1
  86:	e8 75 ff ff ff       	call   0 <printf>
    exit();
  8b:	e8 f8 01 00 00       	call   288 <exit>
      printf(1, "wait stopped early\n");
  90:	83 ec 08             	sub    $0x8,%esp
  93:	68 8b 04 00 00       	push   $0x48b
  98:	6a 01                	push   $0x1
  9a:	e8 61 ff ff ff       	call   0 <printf>
      exit();
  9f:	e8 e4 01 00 00       	call   288 <exit>
    }
  }

  if(wait() != -1){
  a4:	e8 e7 01 00 00       	call   290 <wait>
  a9:	83 f8 ff             	cmp    $0xffffffff,%eax
  ac:	75 17                	jne    c5 <forktest+0xa0>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
  ae:	83 ec 08             	sub    $0x8,%esp
  b1:	68 b2 04 00 00       	push   $0x4b2
  b6:	6a 01                	push   $0x1
  b8:	e8 43 ff ff ff       	call   0 <printf>
}
  bd:	83 c4 10             	add    $0x10,%esp
  c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c3:	c9                   	leave  
  c4:	c3                   	ret    
    printf(1, "wait got too many\n");
  c5:	83 ec 08             	sub    $0x8,%esp
  c8:	68 9f 04 00 00       	push   $0x49f
  cd:	6a 01                	push   $0x1
  cf:	e8 2c ff ff ff       	call   0 <printf>
    exit();
  d4:	e8 af 01 00 00       	call   288 <exit>

000000d9 <main>:

int
main(void)
{
  d9:	55                   	push   %ebp
  da:	89 e5                	mov    %esp,%ebp
  dc:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
  df:	e8 41 ff ff ff       	call   25 <forktest>
  exit();
  e4:	e8 9f 01 00 00       	call   288 <exit>

000000e9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  e9:	55                   	push   %ebp
  ea:	89 e5                	mov    %esp,%ebp
  ec:	56                   	push   %esi
  ed:	53                   	push   %ebx
  ee:	8b 75 08             	mov    0x8(%ebp),%esi
  f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f4:	89 f0                	mov    %esi,%eax
  f6:	89 d1                	mov    %edx,%ecx
  f8:	83 c2 01             	add    $0x1,%edx
  fb:	89 c3                	mov    %eax,%ebx
  fd:	83 c0 01             	add    $0x1,%eax
 100:	0f b6 09             	movzbl (%ecx),%ecx
 103:	88 0b                	mov    %cl,(%ebx)
 105:	84 c9                	test   %cl,%cl
 107:	75 ed                	jne    f6 <strcpy+0xd>
    ;
  return os;
}
 109:	89 f0                	mov    %esi,%eax
 10b:	5b                   	pop    %ebx
 10c:	5e                   	pop    %esi
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    

0000010f <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10f:	55                   	push   %ebp
 110:	89 e5                	mov    %esp,%ebp
 112:	8b 4d 08             	mov    0x8(%ebp),%ecx
 115:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 118:	eb 06                	jmp    120 <strcmp+0x11>
    p++, q++;
 11a:	83 c1 01             	add    $0x1,%ecx
 11d:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 120:	0f b6 01             	movzbl (%ecx),%eax
 123:	84 c0                	test   %al,%al
 125:	74 04                	je     12b <strcmp+0x1c>
 127:	3a 02                	cmp    (%edx),%al
 129:	74 ef                	je     11a <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 12b:	0f b6 c0             	movzbl %al,%eax
 12e:	0f b6 12             	movzbl (%edx),%edx
 131:	29 d0                	sub    %edx,%eax
}
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    

00000135 <strlen>:

uint
strlen(const char *s)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 13b:	b8 00 00 00 00       	mov    $0x0,%eax
 140:	eb 03                	jmp    145 <strlen+0x10>
 142:	83 c0 01             	add    $0x1,%eax
 145:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 149:	75 f7                	jne    142 <strlen+0xd>
    ;
  return n;
}
 14b:	5d                   	pop    %ebp
 14c:	c3                   	ret    

0000014d <memset>:

void*
memset(void *dst, int c, uint n)
{
 14d:	55                   	push   %ebp
 14e:	89 e5                	mov    %esp,%ebp
 150:	57                   	push   %edi
 151:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 154:	89 d7                	mov    %edx,%edi
 156:	8b 4d 10             	mov    0x10(%ebp),%ecx
 159:	8b 45 0c             	mov    0xc(%ebp),%eax
 15c:	fc                   	cld    
 15d:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 15f:	89 d0                	mov    %edx,%eax
 161:	8b 7d fc             	mov    -0x4(%ebp),%edi
 164:	c9                   	leave  
 165:	c3                   	ret    

00000166 <strchr>:

char*
strchr(const char *s, char c)
{
 166:	55                   	push   %ebp
 167:	89 e5                	mov    %esp,%ebp
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 170:	eb 03                	jmp    175 <strchr+0xf>
 172:	83 c0 01             	add    $0x1,%eax
 175:	0f b6 10             	movzbl (%eax),%edx
 178:	84 d2                	test   %dl,%dl
 17a:	74 06                	je     182 <strchr+0x1c>
    if(*s == c)
 17c:	38 ca                	cmp    %cl,%dl
 17e:	75 f2                	jne    172 <strchr+0xc>
 180:	eb 05                	jmp    187 <strchr+0x21>
      return (char*)s;
  return 0;
 182:	b8 00 00 00 00       	mov    $0x0,%eax
}
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    

00000189 <gets>:

char*
gets(char *buf, int max)
{
 189:	55                   	push   %ebp
 18a:	89 e5                	mov    %esp,%ebp
 18c:	57                   	push   %edi
 18d:	56                   	push   %esi
 18e:	53                   	push   %ebx
 18f:	83 ec 1c             	sub    $0x1c,%esp
 192:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	bb 00 00 00 00       	mov    $0x0,%ebx
 19a:	89 de                	mov    %ebx,%esi
 19c:	83 c3 01             	add    $0x1,%ebx
 19f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1a2:	7d 2e                	jge    1d2 <gets+0x49>
    cc = read(0, &c, 1);
 1a4:	83 ec 04             	sub    $0x4,%esp
 1a7:	6a 01                	push   $0x1
 1a9:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ac:	50                   	push   %eax
 1ad:	6a 00                	push   $0x0
 1af:	e8 ec 00 00 00       	call   2a0 <read>
    if(cc < 1)
 1b4:	83 c4 10             	add    $0x10,%esp
 1b7:	85 c0                	test   %eax,%eax
 1b9:	7e 17                	jle    1d2 <gets+0x49>
      break;
    buf[i++] = c;
 1bb:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1bf:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 1c2:	3c 0a                	cmp    $0xa,%al
 1c4:	0f 94 c2             	sete   %dl
 1c7:	3c 0d                	cmp    $0xd,%al
 1c9:	0f 94 c0             	sete   %al
 1cc:	08 c2                	or     %al,%dl
 1ce:	74 ca                	je     19a <gets+0x11>
    buf[i++] = c;
 1d0:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1d2:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1d6:	89 f8                	mov    %edi,%eax
 1d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1db:	5b                   	pop    %ebx
 1dc:	5e                   	pop    %esi
 1dd:	5f                   	pop    %edi
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e5:	83 ec 08             	sub    $0x8,%esp
 1e8:	6a 00                	push   $0x0
 1ea:	ff 75 08             	push   0x8(%ebp)
 1ed:	e8 d6 00 00 00       	call   2c8 <open>
  if(fd < 0)
 1f2:	83 c4 10             	add    $0x10,%esp
 1f5:	85 c0                	test   %eax,%eax
 1f7:	78 24                	js     21d <stat+0x3d>
 1f9:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1fb:	83 ec 08             	sub    $0x8,%esp
 1fe:	ff 75 0c             	push   0xc(%ebp)
 201:	50                   	push   %eax
 202:	e8 d9 00 00 00       	call   2e0 <fstat>
 207:	89 c6                	mov    %eax,%esi
  close(fd);
 209:	89 1c 24             	mov    %ebx,(%esp)
 20c:	e8 9f 00 00 00       	call   2b0 <close>
  return r;
 211:	83 c4 10             	add    $0x10,%esp
}
 214:	89 f0                	mov    %esi,%eax
 216:	8d 65 f8             	lea    -0x8(%ebp),%esp
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
    return -1;
 21d:	be ff ff ff ff       	mov    $0xffffffff,%esi
 222:	eb f0                	jmp    214 <stat+0x34>

00000224 <atoi>:

int
atoi(const char *s)
{
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	53                   	push   %ebx
 228:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 22b:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 230:	eb 10                	jmp    242 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 232:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 235:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 238:	83 c1 01             	add    $0x1,%ecx
 23b:	0f be c0             	movsbl %al,%eax
 23e:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
 242:	0f b6 01             	movzbl (%ecx),%eax
 245:	8d 58 d0             	lea    -0x30(%eax),%ebx
 248:	80 fb 09             	cmp    $0x9,%bl
 24b:	76 e5                	jbe    232 <atoi+0xe>
  return n;
}
 24d:	89 d0                	mov    %edx,%eax
 24f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 252:	c9                   	leave  
 253:	c3                   	ret    

00000254 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	56                   	push   %esi
 258:	53                   	push   %ebx
 259:	8b 75 08             	mov    0x8(%ebp),%esi
 25c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 25f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 262:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 264:	eb 0d                	jmp    273 <memmove+0x1f>
    *dst++ = *src++;
 266:	0f b6 01             	movzbl (%ecx),%eax
 269:	88 02                	mov    %al,(%edx)
 26b:	8d 49 01             	lea    0x1(%ecx),%ecx
 26e:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 271:	89 d8                	mov    %ebx,%eax
 273:	8d 58 ff             	lea    -0x1(%eax),%ebx
 276:	85 c0                	test   %eax,%eax
 278:	7f ec                	jg     266 <memmove+0x12>
  return vdst;
}
 27a:	89 f0                	mov    %esi,%eax
 27c:	5b                   	pop    %ebx
 27d:	5e                   	pop    %esi
 27e:	5d                   	pop    %ebp
 27f:	c3                   	ret    

00000280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 280:	b8 01 00 00 00       	mov    $0x1,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <exit>:
SYSCALL(exit)
 288:	b8 02 00 00 00       	mov    $0x2,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <wait>:
SYSCALL(wait)
 290:	b8 03 00 00 00       	mov    $0x3,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <pipe>:
SYSCALL(pipe)
 298:	b8 04 00 00 00       	mov    $0x4,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <read>:
SYSCALL(read)
 2a0:	b8 05 00 00 00       	mov    $0x5,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <write>:
SYSCALL(write)
 2a8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <close>:
SYSCALL(close)
 2b0:	b8 15 00 00 00       	mov    $0x15,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <kill>:
SYSCALL(kill)
 2b8:	b8 06 00 00 00       	mov    $0x6,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <exec>:
SYSCALL(exec)
 2c0:	b8 07 00 00 00       	mov    $0x7,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <open>:
SYSCALL(open)
 2c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mknod>:
SYSCALL(mknod)
 2d0:	b8 11 00 00 00       	mov    $0x11,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <unlink>:
SYSCALL(unlink)
 2d8:	b8 12 00 00 00       	mov    $0x12,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <fstat>:
SYSCALL(fstat)
 2e0:	b8 08 00 00 00       	mov    $0x8,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <link>:
SYSCALL(link)
 2e8:	b8 13 00 00 00       	mov    $0x13,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mkdir>:
SYSCALL(mkdir)
 2f0:	b8 14 00 00 00       	mov    $0x14,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <chdir>:
SYSCALL(chdir)
 2f8:	b8 09 00 00 00       	mov    $0x9,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <dup>:
SYSCALL(dup)
 300:	b8 0a 00 00 00       	mov    $0xa,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <getpid>:
SYSCALL(getpid)
 308:	b8 0b 00 00 00       	mov    $0xb,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <sbrk>:
SYSCALL(sbrk)
 310:	b8 0c 00 00 00       	mov    $0xc,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <sleep>:
SYSCALL(sleep)
 318:	b8 0d 00 00 00       	mov    $0xd,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <uptime>:
SYSCALL(uptime)
 320:	b8 0e 00 00 00       	mov    $0xe,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <clone>:
SYSCALL(clone)
 328:	b8 16 00 00 00       	mov    $0x16,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <join>:
SYSCALL(join)
 330:	b8 17 00 00 00       	mov    $0x17,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	57                   	push   %edi
 33c:	56                   	push   %esi
 33d:	53                   	push   %ebx
 33e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 341:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 344:	a1 30 07 00 00       	mov    0x730,%eax
 349:	eb 02                	jmp    34d <free+0x15>
 34b:	89 d0                	mov    %edx,%eax
 34d:	39 c8                	cmp    %ecx,%eax
 34f:	73 04                	jae    355 <free+0x1d>
 351:	39 08                	cmp    %ecx,(%eax)
 353:	77 12                	ja     367 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 355:	8b 10                	mov    (%eax),%edx
 357:	39 c2                	cmp    %eax,%edx
 359:	77 f0                	ja     34b <free+0x13>
 35b:	39 c8                	cmp    %ecx,%eax
 35d:	72 08                	jb     367 <free+0x2f>
 35f:	39 ca                	cmp    %ecx,%edx
 361:	77 04                	ja     367 <free+0x2f>
 363:	89 d0                	mov    %edx,%eax
 365:	eb e6                	jmp    34d <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 367:	8b 73 fc             	mov    -0x4(%ebx),%esi
 36a:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 36d:	8b 10                	mov    (%eax),%edx
 36f:	39 d7                	cmp    %edx,%edi
 371:	74 19                	je     38c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 373:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 376:	8b 50 04             	mov    0x4(%eax),%edx
 379:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 37c:	39 ce                	cmp    %ecx,%esi
 37e:	74 1b                	je     39b <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 380:	89 08                	mov    %ecx,(%eax)
  freep = p;
 382:	a3 30 07 00 00       	mov    %eax,0x730
}
 387:	5b                   	pop    %ebx
 388:	5e                   	pop    %esi
 389:	5f                   	pop    %edi
 38a:	5d                   	pop    %ebp
 38b:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 38c:	03 72 04             	add    0x4(%edx),%esi
 38f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 392:	8b 10                	mov    (%eax),%edx
 394:	8b 12                	mov    (%edx),%edx
 396:	89 53 f8             	mov    %edx,-0x8(%ebx)
 399:	eb db                	jmp    376 <free+0x3e>
    p->s.size += bp->s.size;
 39b:	03 53 fc             	add    -0x4(%ebx),%edx
 39e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 3a1:	8b 53 f8             	mov    -0x8(%ebx),%edx
 3a4:	89 10                	mov    %edx,(%eax)
 3a6:	eb da                	jmp    382 <free+0x4a>

000003a8 <morecore>:

static Header*
morecore(uint nu)
{
 3a8:	55                   	push   %ebp
 3a9:	89 e5                	mov    %esp,%ebp
 3ab:	53                   	push   %ebx
 3ac:	83 ec 04             	sub    $0x4,%esp
 3af:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 3b1:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 3b6:	77 05                	ja     3bd <morecore+0x15>
    nu = 4096;
 3b8:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 3bd:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 3c4:	83 ec 0c             	sub    $0xc,%esp
 3c7:	50                   	push   %eax
 3c8:	e8 43 ff ff ff       	call   310 <sbrk>
  if(p == (char*)-1)
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	83 f8 ff             	cmp    $0xffffffff,%eax
 3d3:	74 1c                	je     3f1 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 3d5:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 3d8:	83 c0 08             	add    $0x8,%eax
 3db:	83 ec 0c             	sub    $0xc,%esp
 3de:	50                   	push   %eax
 3df:	e8 54 ff ff ff       	call   338 <free>
  return freep;
 3e4:	a1 30 07 00 00       	mov    0x730,%eax
 3e9:	83 c4 10             	add    $0x10,%esp
}
 3ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ef:	c9                   	leave  
 3f0:	c3                   	ret    
    return 0;
 3f1:	b8 00 00 00 00       	mov    $0x0,%eax
 3f6:	eb f4                	jmp    3ec <morecore+0x44>

000003f8 <malloc>:

void*
malloc(uint nbytes)
{
 3f8:	55                   	push   %ebp
 3f9:	89 e5                	mov    %esp,%ebp
 3fb:	53                   	push   %ebx
 3fc:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 3ff:	8b 45 08             	mov    0x8(%ebp),%eax
 402:	8d 58 07             	lea    0x7(%eax),%ebx
 405:	c1 eb 03             	shr    $0x3,%ebx
 408:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 40b:	8b 0d 30 07 00 00    	mov    0x730,%ecx
 411:	85 c9                	test   %ecx,%ecx
 413:	74 04                	je     419 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 415:	8b 01                	mov    (%ecx),%eax
 417:	eb 4a                	jmp    463 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
 419:	c7 05 30 07 00 00 34 	movl   $0x734,0x730
 420:	07 00 00 
 423:	c7 05 34 07 00 00 34 	movl   $0x734,0x734
 42a:	07 00 00 
    base.s.size = 0;
 42d:	c7 05 38 07 00 00 00 	movl   $0x0,0x738
 434:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 437:	b9 34 07 00 00       	mov    $0x734,%ecx
 43c:	eb d7                	jmp    415 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 43e:	74 19                	je     459 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 440:	29 da                	sub    %ebx,%edx
 442:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 445:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 448:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 44b:	89 0d 30 07 00 00    	mov    %ecx,0x730
      return (void*)(p + 1);
 451:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 454:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 457:	c9                   	leave  
 458:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 459:	8b 10                	mov    (%eax),%edx
 45b:	89 11                	mov    %edx,(%ecx)
 45d:	eb ec                	jmp    44b <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 45f:	89 c1                	mov    %eax,%ecx
 461:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 463:	8b 50 04             	mov    0x4(%eax),%edx
 466:	39 da                	cmp    %ebx,%edx
 468:	73 d4                	jae    43e <malloc+0x46>
    if(p == freep)
 46a:	39 05 30 07 00 00    	cmp    %eax,0x730
 470:	75 ed                	jne    45f <malloc+0x67>
      if((p = morecore(nunits)) == 0)
 472:	89 d8                	mov    %ebx,%eax
 474:	e8 2f ff ff ff       	call   3a8 <morecore>
 479:	85 c0                	test   %eax,%eax
 47b:	75 e2                	jne    45f <malloc+0x67>
 47d:	eb d5                	jmp    454 <malloc+0x5c>
