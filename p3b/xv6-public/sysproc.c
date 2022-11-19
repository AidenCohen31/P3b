#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


int sys_clone(void){
  void (*fptr)(void*, void*);
  void* a1;
  void * a2;
  void * stack;
  if(argptr(0,((char**)&fptr),0) < 0 || argptr(1, ((char**)&a1), 0) < 0 || argptr(2,((char**)&a2), 0) < 0 || argptr(3,((char**)&stack), 0) < 0){
    return -1;
  }
  int pid = clone(fptr,a1,a2,stack);
  return pid;  
}

int sys_join(void){
  void ** stack;

  if(argptr(0,((char**)&stack),0) < 0){
    return -1;
  }

  if(stack < 0 || myproc()->sz < (uint) stack + 4 ){
    return -1;
  }
  int pid = join(stack);
  return pid;
}