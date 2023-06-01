
./out/smith_9/dcir/.dacecache/sdfg_0/build/CMakeFiles/sdfg_0.dir/home/xdb/AST/out/smith_9/dcir/.dacecache/sdfg_0/src/cpu/sdfg_0.cpp.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <_Z25__program_sdfg_0_internalP8sdfg_0_tPi>:
   0:	41 57                	push   %r15
   2:	41 56                	push   %r14
   4:	53                   	push   %rbx
   5:	48 83 ec 10          	sub    $0x10,%rsp
   9:	48 89 f3             	mov    %rsi,%rbx
   c:	49 89 fe             	mov    %rdi,%r14
   f:	e8 00 00 00 00       	callq  14 <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x14>
  14:	49 89 c7             	mov    %rax,%r15
  17:	e8 00 00 00 00       	callq  1c <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x1c>
  1c:	e8 00 00 00 00       	callq  21 <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x21>
  21:	c7 03 00 00 00 00    	movl   $0x0,(%rbx)
  27:	e8 00 00 00 00       	callq  2c <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x2c>
  2c:	48 89 c1             	mov    %rax,%rcx
  2f:	48 be cf f7 53 e3 a5 	movabs $0x20c49ba5e353f7cf,%rsi
  36:	9b c4 20 
  39:	4c 89 f8             	mov    %r15,%rax
  3c:	48 f7 ee             	imul   %rsi
  3f:	49 89 d7             	mov    %rdx,%r15
  42:	48 89 c8             	mov    %rcx,%rax
  45:	48 f7 ee             	imul   %rsi
  48:	48 89 d3             	mov    %rdx,%rbx
  4b:	b8 01 00 00 00       	mov    $0x1,%eax
  50:	48 83 3d 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # 58 <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x58>
  57:	00 
  58:	74 05                	je     5f <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x5f>
  5a:	e8 00 00 00 00       	callq  5f <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x5f>
  5f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  64:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
  69:	be 08 00 00 00       	mov    $0x8,%esi
  6e:	ba 07 69 0f c7       	mov    $0xc70f6907,%edx
  73:	e8 00 00 00 00       	callq  78 <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x78>
  78:	4c 89 f9             	mov    %r15,%rcx
  7b:	48 c1 e9 3f          	shr    $0x3f,%rcx
  7f:	49 c1 ff 07          	sar    $0x7,%r15
  83:	49 01 cf             	add    %rcx,%r15
  86:	48 89 d9             	mov    %rbx,%rcx
  89:	48 c1 e9 3f          	shr    $0x3f,%rcx
  8d:	48 c1 fb 07          	sar    $0x7,%rbx
  91:	48 01 cb             	add    %rcx,%rbx
  94:	48 83 ec 08          	sub    $0x8,%rsp
  98:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 9f <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0x9f>
  9f:	48 8d 15 00 00 00 00 	lea    0x0(%rip),%rdx        # a6 <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0xa6>
  a6:	4c 89 f7             	mov    %r14,%rdi
  a9:	4c 89 f9             	mov    %r15,%rcx
  ac:	49 89 d8             	mov    %rbx,%r8
  af:	49 89 c1             	mov    %rax,%r9
  b2:	6a ff                	pushq  $0xffffffffffffffff
  b4:	6a ff                	pushq  $0xffffffffffffffff
  b6:	6a 00                	pushq  $0x0
  b8:	e8 00 00 00 00       	callq  bd <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0xbd>
  bd:	48 83 c4 30          	add    $0x30,%rsp
  c1:	5b                   	pop    %rbx
  c2:	41 5e                	pop    %r14
  c4:	41 5f                	pop    %r15
  c6:	c3                   	retq   
  c7:	48 89 c7             	mov    %rax,%rdi
  ca:	e8 00 00 00 00       	callq  cf <_Z25__program_sdfg_0_internalP8sdfg_0_tPi+0xcf>
  cf:	90                   	nop

00000000000000d0 <__program_sdfg_0>:
  d0:	e9 00 00 00 00       	jmpq   d5 <__program_sdfg_0+0x5>
  d5:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  dc:	00 00 00 
  df:	90                   	nop

00000000000000e0 <__dace_init_sdfg_0>:
  e0:	50                   	push   %rax
  e1:	bf 40 00 00 00       	mov    $0x40,%edi
  e6:	e8 00 00 00 00       	callq  eb <__dace_init_sdfg_0+0xb>
  eb:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  ef:	c5 fc 11 00          	vmovups %ymm0,(%rax)
  f3:	c5 fc 11 40 20       	vmovups %ymm0,0x20(%rax)
  f8:	59                   	pop    %rcx
  f9:	c5 f8 77             	vzeroupper 
  fc:	c3                   	retq   
  fd:	0f 1f 00             	nopl   (%rax)

0000000000000100 <__dace_exit_sdfg_0>:
 100:	53                   	push   %rbx
 101:	48 89 fb             	mov    %rdi,%rbx
 104:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 10b <__dace_exit_sdfg_0+0xb>
 10b:	48 8d 15 00 00 00 00 	lea    0x0(%rip),%rdx        # 112 <__dace_exit_sdfg_0+0x12>
 112:	e8 00 00 00 00       	callq  117 <__dace_exit_sdfg_0+0x17>
 117:	48 85 db             	test   %rbx,%rbx
 11a:	74 17                	je     133 <__dace_exit_sdfg_0+0x33>
 11c:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
 120:	48 85 ff             	test   %rdi,%rdi
 123:	74 05                	je     12a <__dace_exit_sdfg_0+0x2a>
 125:	e8 00 00 00 00       	callq  12a <__dace_exit_sdfg_0+0x2a>
 12a:	48 89 df             	mov    %rbx,%rdi
 12d:	5b                   	pop    %rbx
 12e:	e9 00 00 00 00       	jmpq   133 <__dace_exit_sdfg_0+0x33>
 133:	5b                   	pop    %rbx
 134:	c3                   	retq   

Disassembly of section .text._ZN4dace4perf6Report4saveEPKcS3_:

0000000000000000 <_ZN4dace4perf6Report4saveEPKcS3_>:
   0:	55                   	push   %rbp
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 55                	push   %r13
   7:	41 54                	push   %r12
   9:	53                   	push   %rbx
   a:	48 81 ec d8 03 00 00 	sub    $0x3d8,%rsp
  11:	49 89 d4             	mov    %rdx,%r12
  14:	48 89 f5             	mov    %rsi,%rbp
  17:	49 89 ff             	mov    %rdi,%r15
  1a:	48 83 3d 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # 22 <_ZN4dace4perf6Report4saveEPKcS3_+0x22>
  21:	00 
  22:	74 10                	je     34 <_ZN4dace4perf6Report4saveEPKcS3_+0x34>
  24:	4c 89 ff             	mov    %r15,%rdi
  27:	e8 00 00 00 00       	callq  2c <_ZN4dace4perf6Report4saveEPKcS3_+0x2c>
  2c:	85 c0                	test   %eax,%eax
  2e:	0f 85 5a 08 00 00    	jne    88e <_ZN4dace4perf6Report4saveEPKcS3_+0x88e>
  34:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
  39:	e8 00 00 00 00       	callq  3e <_ZN4dace4perf6Report4saveEPKcS3_+0x3e>
  3e:	e8 00 00 00 00       	callq  43 <_ZN4dace4perf6Report4saveEPKcS3_+0x43>
  43:	48 b9 db 34 b6 d7 82 	movabs $0x431bde82d7b634db,%rcx
  4a:	de 1b 43 
  4d:	48 f7 e9             	imul   %rcx
  50:	48 89 d3             	mov    %rdx,%rbx
  53:	4c 8d 74 24 60       	lea    0x60(%rsp),%r14
  58:	48 85 ed             	test   %rbp,%rbp
  5b:	74 18                	je     75 <_ZN4dace4perf6Report4saveEPKcS3_+0x75>
  5d:	48 89 ef             	mov    %rbp,%rdi
  60:	e8 00 00 00 00       	callq  65 <_ZN4dace4perf6Report4saveEPKcS3_+0x65>
  65:	4c 89 f7             	mov    %r14,%rdi
  68:	48 89 ee             	mov    %rbp,%rsi
  6b:	48 89 c2             	mov    %rax,%rdx
  6e:	e8 00 00 00 00       	callq  73 <_ZN4dace4perf6Report4saveEPKcS3_+0x73>
  73:	eb 1c                	jmp    91 <_ZN4dace4perf6Report4saveEPKcS3_+0x91>
  75:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  7a:	48 8b 40 e8          	mov    -0x18(%rax),%rax
  7e:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
  82:	8b b4 04 80 00 00 00 	mov    0x80(%rsp,%rax,1),%esi
  89:	83 ce 01             	or     $0x1,%esi
  8c:	e8 00 00 00 00       	callq  91 <_ZN4dace4perf6Report4saveEPKcS3_+0x91>
  91:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 98 <_ZN4dace4perf6Report4saveEPKcS3_+0x98>
  98:	ba 01 00 00 00       	mov    $0x1,%edx
  9d:	4c 89 f7             	mov    %r14,%rdi
  a0:	e8 00 00 00 00       	callq  a5 <_ZN4dace4perf6Report4saveEPKcS3_+0xa5>
  a5:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # ac <_ZN4dace4perf6Report4saveEPKcS3_+0xac>
  ac:	ba 07 00 00 00       	mov    $0x7,%edx
  b1:	4c 89 f7             	mov    %r14,%rdi
  b4:	e8 00 00 00 00       	callq  b9 <_ZN4dace4perf6Report4saveEPKcS3_+0xb9>
  b9:	48 89 d8             	mov    %rbx,%rax
  bc:	48 c1 e8 3f          	shr    $0x3f,%rax
  c0:	48 c1 fb 12          	sar    $0x12,%rbx
  c4:	48 01 c3             	add    %rax,%rbx
  c7:	4c 89 f7             	mov    %r14,%rdi
  ca:	48 89 de             	mov    %rbx,%rsi
  cd:	e8 00 00 00 00       	callq  d2 <_ZN4dace4perf6Report4saveEPKcS3_+0xd2>
  d2:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # d9 <_ZN4dace4perf6Report4saveEPKcS3_+0xd9>
  d9:	ba 05 00 00 00       	mov    $0x5,%edx
  de:	48 89 c7             	mov    %rax,%rdi
  e1:	e8 00 00 00 00       	callq  e6 <_ZN4dace4perf6Report4saveEPKcS3_+0xe6>
  e6:	48 8d 74 24 68       	lea    0x68(%rsp),%rsi
  eb:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
  f0:	e8 00 00 00 00       	callq  f5 <_ZN4dace4perf6Report4saveEPKcS3_+0xf5>
  f5:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
  fc:	00 
  fd:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
 102:	ba 04 00 00 00       	mov    $0x4,%edx
 107:	e8 00 00 00 00       	callq  10c <_ZN4dace4perf6Report4saveEPKcS3_+0x10c>
 10c:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
 111:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
 116:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
 11b:	48 39 c7             	cmp    %rax,%rdi
 11e:	74 05                	je     125 <_ZN4dace4perf6Report4saveEPKcS3_+0x125>
 120:	e8 00 00 00 00       	callq  125 <_ZN4dace4perf6Report4saveEPKcS3_+0x125>
 125:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 12c <_ZN4dace4perf6Report4saveEPKcS3_+0x12c>
 12c:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 133:	00 
 134:	ba 01 00 00 00       	mov    $0x1,%edx
 139:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
 13e:	e8 00 00 00 00       	callq  143 <_ZN4dace4perf6Report4saveEPKcS3_+0x143>
 143:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
 14a:	00 
 14b:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 14f:	48 8b 9c 04 c8 02 00 	mov    0x2c8(%rsp,%rax,1),%rbx
 156:	00 
 157:	48 85 db             	test   %rbx,%rbx
 15a:	0f 84 10 07 00 00    	je     870 <_ZN4dace4perf6Report4saveEPKcS3_+0x870>
 160:	80 7b 38 00          	cmpb   $0x0,0x38(%rbx)
 164:	74 05                	je     16b <_ZN4dace4perf6Report4saveEPKcS3_+0x16b>
 166:	8a 43 43             	mov    0x43(%rbx),%al
 169:	eb 16                	jmp    181 <_ZN4dace4perf6Report4saveEPKcS3_+0x181>
 16b:	48 89 df             	mov    %rbx,%rdi
 16e:	e8 00 00 00 00       	callq  173 <_ZN4dace4perf6Report4saveEPKcS3_+0x173>
 173:	48 8b 03             	mov    (%rbx),%rax
 176:	48 89 df             	mov    %rbx,%rdi
 179:	be 0a 00 00 00       	mov    $0xa,%esi
 17e:	ff 50 30             	callq  *0x30(%rax)
 181:	0f be f0             	movsbl %al,%esi
 184:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 18b:	00 
 18c:	e8 00 00 00 00       	callq  191 <_ZN4dace4perf6Report4saveEPKcS3_+0x191>
 191:	48 89 c7             	mov    %rax,%rdi
 194:	e8 00 00 00 00       	callq  199 <_ZN4dace4perf6Report4saveEPKcS3_+0x199>
 199:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 1a0 <_ZN4dace4perf6Report4saveEPKcS3_+0x1a0>
 1a0:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 1a7:	00 
 1a8:	ba 12 00 00 00       	mov    $0x12,%edx
 1ad:	e8 00 00 00 00       	callq  1b2 <_ZN4dace4perf6Report4saveEPKcS3_+0x1b2>
 1b2:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
 1b9:	00 
 1ba:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 1be:	48 8b 9c 04 c8 02 00 	mov    0x2c8(%rsp,%rax,1),%rbx
 1c5:	00 
 1c6:	48 85 db             	test   %rbx,%rbx
 1c9:	0f 84 a6 06 00 00    	je     875 <_ZN4dace4perf6Report4saveEPKcS3_+0x875>
 1cf:	80 7b 38 00          	cmpb   $0x0,0x38(%rbx)
 1d3:	74 05                	je     1da <_ZN4dace4perf6Report4saveEPKcS3_+0x1da>
 1d5:	8a 43 43             	mov    0x43(%rbx),%al
 1d8:	eb 16                	jmp    1f0 <_ZN4dace4perf6Report4saveEPKcS3_+0x1f0>
 1da:	48 89 df             	mov    %rbx,%rdi
 1dd:	e8 00 00 00 00       	callq  1e2 <_ZN4dace4perf6Report4saveEPKcS3_+0x1e2>
 1e2:	48 8b 03             	mov    (%rbx),%rax
 1e5:	48 89 df             	mov    %rbx,%rdi
 1e8:	be 0a 00 00 00       	mov    $0xa,%esi
 1ed:	ff 50 30             	callq  *0x30(%rax)
 1f0:	0f be f0             	movsbl %al,%esi
 1f3:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 1fa:	00 
 1fb:	e8 00 00 00 00       	callq  200 <_ZN4dace4perf6Report4saveEPKcS3_+0x200>
 200:	48 89 c7             	mov    %rax,%rdi
 203:	e8 00 00 00 00       	callq  208 <_ZN4dace4perf6Report4saveEPKcS3_+0x208>
 208:	e8 00 00 00 00       	callq  20d <_ZN4dace4perf6Report4saveEPKcS3_+0x20d>
 20d:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
 211:	4d 8b 77 28          	mov    0x28(%r15),%r14
 215:	49 8b 47 30          	mov    0x30(%r15),%rax
 219:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
 21e:	49 39 c6             	cmp    %rax,%r14
 221:	0f 84 44 03 00 00    	je     56b <_ZN4dace4perf6Report4saveEPKcS3_+0x56b>
 227:	b0 01                	mov    $0x1,%al
 229:	89 44 24 0c          	mov    %eax,0xc(%rsp)
 22d:	48 8d 9c 24 d8 01 00 	lea    0x1d8(%rsp),%rbx
 234:	00 
 235:	4c 8d 3d 00 00 00 00 	lea    0x0(%rip),%r15        # 23c <_ZN4dace4perf6Report4saveEPKcS3_+0x23c>
 23c:	4c 8d 2d 00 00 00 00 	lea    0x0(%rip),%r13        # 243 <_ZN4dace4perf6Report4saveEPKcS3_+0x243>
 243:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 24a:	00 00 00 
 24d:	0f 1f 00             	nopl   (%rax)
 250:	f6 44 24 0c 01       	testb  $0x1,0xc(%rsp)
 255:	75 49                	jne    2a0 <_ZN4dace4perf6Report4saveEPKcS3_+0x2a0>
 257:	ba 01 00 00 00       	mov    $0x1,%edx
 25c:	48 89 df             	mov    %rbx,%rdi
 25f:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 266 <_ZN4dace4perf6Report4saveEPKcS3_+0x266>
 266:	e8 00 00 00 00       	callq  26b <_ZN4dace4perf6Report4saveEPKcS3_+0x26b>
 26b:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
 272:	00 
 273:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 277:	4c 8b a4 04 c8 02 00 	mov    0x2c8(%rsp,%rax,1),%r12
 27e:	00 
 27f:	4d 85 e4             	test   %r12,%r12
 282:	0f 84 e3 05 00 00    	je     86b <_ZN4dace4perf6Report4saveEPKcS3_+0x86b>
 288:	41 80 7c 24 38 00    	cmpb   $0x0,0x38(%r12)
 28e:	74 1a                	je     2aa <_ZN4dace4perf6Report4saveEPKcS3_+0x2aa>
 290:	41 0f b6 44 24 43    	movzbl 0x43(%r12),%eax
 296:	eb 29                	jmp    2c1 <_ZN4dace4perf6Report4saveEPKcS3_+0x2c1>
 298:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 29f:	00 
 2a0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
 2a7:	00 
 2a8:	eb 2a                	jmp    2d4 <_ZN4dace4perf6Report4saveEPKcS3_+0x2d4>
 2aa:	4c 89 e7             	mov    %r12,%rdi
 2ad:	e8 00 00 00 00       	callq  2b2 <_ZN4dace4perf6Report4saveEPKcS3_+0x2b2>
 2b2:	49 8b 04 24          	mov    (%r12),%rax
 2b6:	4c 89 e7             	mov    %r12,%rdi
 2b9:	be 0a 00 00 00       	mov    $0xa,%esi
 2be:	ff 50 30             	callq  *0x30(%rax)
 2c1:	0f be f0             	movsbl %al,%esi
 2c4:	48 89 df             	mov    %rbx,%rdi
 2c7:	e8 00 00 00 00       	callq  2cc <_ZN4dace4perf6Report4saveEPKcS3_+0x2cc>
 2cc:	48 89 c7             	mov    %rax,%rdi
 2cf:	e8 00 00 00 00       	callq  2d4 <_ZN4dace4perf6Report4saveEPKcS3_+0x2d4>
 2d4:	ba 05 00 00 00       	mov    $0x5,%edx
 2d9:	48 89 df             	mov    %rbx,%rdi
 2dc:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 2e3 <_ZN4dace4perf6Report4saveEPKcS3_+0x2e3>
 2e3:	e8 00 00 00 00       	callq  2e8 <_ZN4dace4perf6Report4saveEPKcS3_+0x2e8>
 2e8:	ba 09 00 00 00       	mov    $0x9,%edx
 2ed:	48 89 df             	mov    %rbx,%rdi
 2f0:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 2f7 <_ZN4dace4perf6Report4saveEPKcS3_+0x2f7>
 2f7:	e8 00 00 00 00       	callq  2fc <_ZN4dace4perf6Report4saveEPKcS3_+0x2fc>
 2fc:	49 8d 6e 01          	lea    0x1(%r14),%rbp
 300:	48 89 ef             	mov    %rbp,%rdi
 303:	e8 00 00 00 00       	callq  308 <_ZN4dace4perf6Report4saveEPKcS3_+0x308>
 308:	48 89 df             	mov    %rbx,%rdi
 30b:	48 89 ee             	mov    %rbp,%rsi
 30e:	48 89 c2             	mov    %rax,%rdx
 311:	e8 00 00 00 00       	callq  316 <_ZN4dace4perf6Report4saveEPKcS3_+0x316>
 316:	ba 03 00 00 00       	mov    $0x3,%edx
 31b:	48 89 df             	mov    %rbx,%rdi
 31e:	4c 89 fe             	mov    %r15,%rsi
 321:	e8 00 00 00 00       	callq  326 <_ZN4dace4perf6Report4saveEPKcS3_+0x326>
 326:	ba 08 00 00 00       	mov    $0x8,%edx
 32b:	48 89 df             	mov    %rbx,%rdi
 32e:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 335 <_ZN4dace4perf6Report4saveEPKcS3_+0x335>
 335:	e8 00 00 00 00       	callq  33a <_ZN4dace4perf6Report4saveEPKcS3_+0x33a>
 33a:	49 8d 6e 41          	lea    0x41(%r14),%rbp
 33e:	48 89 ef             	mov    %rbp,%rdi
 341:	e8 00 00 00 00       	callq  346 <_ZN4dace4perf6Report4saveEPKcS3_+0x346>
 346:	48 89 df             	mov    %rbx,%rdi
 349:	48 89 ee             	mov    %rbp,%rsi
 34c:	48 89 c2             	mov    %rax,%rdx
 34f:	e8 00 00 00 00       	callq  354 <_ZN4dace4perf6Report4saveEPKcS3_+0x354>
 354:	ba 03 00 00 00       	mov    $0x3,%edx
 359:	48 89 df             	mov    %rbx,%rdi
 35c:	4c 89 fe             	mov    %r15,%rsi
 35f:	e8 00 00 00 00       	callq  364 <_ZN4dace4perf6Report4saveEPKcS3_+0x364>
 364:	ba 07 00 00 00       	mov    $0x7,%edx
 369:	48 89 df             	mov    %rbx,%rdi
 36c:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 373 <_ZN4dace4perf6Report4saveEPKcS3_+0x373>
 373:	e8 00 00 00 00       	callq  378 <_ZN4dace4perf6Report4saveEPKcS3_+0x378>
 378:	41 0f b6 06          	movzbl (%r14),%eax
 37c:	88 44 24 30          	mov    %al,0x30(%rsp)
 380:	ba 01 00 00 00       	mov    $0x1,%edx
 385:	48 89 df             	mov    %rbx,%rdi
 388:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
 38d:	e8 00 00 00 00       	callq  392 <_ZN4dace4perf6Report4saveEPKcS3_+0x392>
 392:	ba 03 00 00 00       	mov    $0x3,%edx
 397:	48 89 c7             	mov    %rax,%rdi
 39a:	4c 89 fe             	mov    %r15,%rsi
 39d:	e8 00 00 00 00       	callq  3a2 <_ZN4dace4perf6Report4saveEPKcS3_+0x3a2>
 3a2:	ba 06 00 00 00       	mov    $0x6,%edx
 3a7:	48 89 df             	mov    %rbx,%rdi
 3aa:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 3b1 <_ZN4dace4perf6Report4saveEPKcS3_+0x3b1>
 3b1:	e8 00 00 00 00       	callq  3b6 <_ZN4dace4perf6Report4saveEPKcS3_+0x3b6>
 3b6:	49 8b 76 50          	mov    0x50(%r14),%rsi
 3ba:	48 89 df             	mov    %rbx,%rdi
 3bd:	e8 00 00 00 00       	callq  3c2 <_ZN4dace4perf6Report4saveEPKcS3_+0x3c2>
 3c2:	ba 02 00 00 00       	mov    $0x2,%edx
 3c7:	48 89 c7             	mov    %rax,%rdi
 3ca:	4c 89 ee             	mov    %r13,%rsi
 3cd:	e8 00 00 00 00       	callq  3d2 <_ZN4dace4perf6Report4saveEPKcS3_+0x3d2>
 3d2:	41 80 3e 58          	cmpb   $0x58,(%r14)
 3d6:	75 34                	jne    40c <_ZN4dace4perf6Report4saveEPKcS3_+0x40c>
 3d8:	ba 07 00 00 00       	mov    $0x7,%edx
 3dd:	48 89 df             	mov    %rbx,%rdi
 3e0:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 3e7 <_ZN4dace4perf6Report4saveEPKcS3_+0x3e7>
 3e7:	e8 00 00 00 00       	callq  3ec <_ZN4dace4perf6Report4saveEPKcS3_+0x3ec>
 3ec:	49 8b 76 58          	mov    0x58(%r14),%rsi
 3f0:	49 2b 76 50          	sub    0x50(%r14),%rsi
 3f4:	48 89 df             	mov    %rbx,%rdi
 3f7:	e8 00 00 00 00       	callq  3fc <_ZN4dace4perf6Report4saveEPKcS3_+0x3fc>
 3fc:	ba 02 00 00 00       	mov    $0x2,%edx
 401:	48 89 c7             	mov    %rax,%rdi
 404:	4c 89 ee             	mov    %r13,%rsi
 407:	e8 00 00 00 00       	callq  40c <_ZN4dace4perf6Report4saveEPKcS3_+0x40c>
 40c:	ba 07 00 00 00       	mov    $0x7,%edx
 411:	48 89 df             	mov    %rbx,%rdi
 414:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 41b <_ZN4dace4perf6Report4saveEPKcS3_+0x41b>
 41b:	e8 00 00 00 00       	callq  420 <_ZN4dace4perf6Report4saveEPKcS3_+0x420>
 420:	48 89 df             	mov    %rbx,%rdi
 423:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
 427:	e8 00 00 00 00       	callq  42c <_ZN4dace4perf6Report4saveEPKcS3_+0x42c>
 42c:	ba 02 00 00 00       	mov    $0x2,%edx
 431:	48 89 c7             	mov    %rax,%rdi
 434:	4c 89 ee             	mov    %r13,%rsi
 437:	e8 00 00 00 00       	callq  43c <_ZN4dace4perf6Report4saveEPKcS3_+0x43c>
 43c:	ba 07 00 00 00       	mov    $0x7,%edx
 441:	48 89 df             	mov    %rbx,%rdi
 444:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 44b <_ZN4dace4perf6Report4saveEPKcS3_+0x44b>
 44b:	e8 00 00 00 00       	callq  450 <_ZN4dace4perf6Report4saveEPKcS3_+0x450>
 450:	49 8b 76 60          	mov    0x60(%r14),%rsi
 454:	48 89 df             	mov    %rbx,%rdi
 457:	e8 00 00 00 00       	callq  45c <_ZN4dace4perf6Report4saveEPKcS3_+0x45c>
 45c:	ba 02 00 00 00       	mov    $0x2,%edx
 461:	48 89 c7             	mov    %rax,%rdi
 464:	4c 89 ee             	mov    %r13,%rsi
 467:	e8 00 00 00 00       	callq  46c <_ZN4dace4perf6Report4saveEPKcS3_+0x46c>
 46c:	ba 09 00 00 00       	mov    $0x9,%edx
 471:	48 89 df             	mov    %rbx,%rdi
 474:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 47b <_ZN4dace4perf6Report4saveEPKcS3_+0x47b>
 47b:	e8 00 00 00 00       	callq  480 <_ZN4dace4perf6Report4saveEPKcS3_+0x480>
 480:	ba 0b 00 00 00       	mov    $0xb,%edx
 485:	48 89 df             	mov    %rbx,%rdi
 488:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 48f <_ZN4dace4perf6Report4saveEPKcS3_+0x48f>
 48f:	e8 00 00 00 00       	callq  494 <_ZN4dace4perf6Report4saveEPKcS3_+0x494>
 494:	41 8b 76 68          	mov    0x68(%r14),%esi
 498:	48 89 df             	mov    %rbx,%rdi
 49b:	e8 00 00 00 00       	callq  4a0 <_ZN4dace4perf6Report4saveEPKcS3_+0x4a0>
 4a0:	41 83 7e 6c 00       	cmpl   $0x0,0x6c(%r14)
 4a5:	78 20                	js     4c7 <_ZN4dace4perf6Report4saveEPKcS3_+0x4c7>
 4a7:	ba 0e 00 00 00       	mov    $0xe,%edx
 4ac:	48 89 df             	mov    %rbx,%rdi
 4af:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 4b6 <_ZN4dace4perf6Report4saveEPKcS3_+0x4b6>
 4b6:	e8 00 00 00 00       	callq  4bb <_ZN4dace4perf6Report4saveEPKcS3_+0x4bb>
 4bb:	41 8b 76 6c          	mov    0x6c(%r14),%esi
 4bf:	48 89 df             	mov    %rbx,%rdi
 4c2:	e8 00 00 00 00       	callq  4c7 <_ZN4dace4perf6Report4saveEPKcS3_+0x4c7>
 4c7:	41 83 7e 70 00       	cmpl   $0x0,0x70(%r14)
 4cc:	78 20                	js     4ee <_ZN4dace4perf6Report4saveEPKcS3_+0x4ee>
 4ce:	ba 08 00 00 00       	mov    $0x8,%edx
 4d3:	48 89 df             	mov    %rbx,%rdi
 4d6:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 4dd <_ZN4dace4perf6Report4saveEPKcS3_+0x4dd>
 4dd:	e8 00 00 00 00       	callq  4e2 <_ZN4dace4perf6Report4saveEPKcS3_+0x4e2>
 4e2:	41 8b 76 70          	mov    0x70(%r14),%esi
 4e6:	48 89 df             	mov    %rbx,%rdi
 4e9:	e8 00 00 00 00       	callq  4ee <_ZN4dace4perf6Report4saveEPKcS3_+0x4ee>
 4ee:	41 80 3e 43          	cmpb   $0x43,(%r14)
 4f2:	75 51                	jne    545 <_ZN4dace4perf6Report4saveEPKcS3_+0x545>
 4f4:	ba 03 00 00 00       	mov    $0x3,%edx
 4f9:	48 89 df             	mov    %rbx,%rdi
 4fc:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 503 <_ZN4dace4perf6Report4saveEPKcS3_+0x503>
 503:	e8 00 00 00 00       	callq  508 <_ZN4dace4perf6Report4saveEPKcS3_+0x508>
 508:	49 8d 6e 78          	lea    0x78(%r14),%rbp
 50c:	48 89 ef             	mov    %rbp,%rdi
 50f:	e8 00 00 00 00       	callq  514 <_ZN4dace4perf6Report4saveEPKcS3_+0x514>
 514:	48 89 df             	mov    %rbx,%rdi
 517:	48 89 ee             	mov    %rbp,%rsi
 51a:	48 89 c2             	mov    %rax,%rdx
 51d:	e8 00 00 00 00       	callq  522 <_ZN4dace4perf6Report4saveEPKcS3_+0x522>
 522:	ba 03 00 00 00       	mov    $0x3,%edx
 527:	48 89 df             	mov    %rbx,%rdi
 52a:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 531 <_ZN4dace4perf6Report4saveEPKcS3_+0x531>
 531:	e8 00 00 00 00       	callq  536 <_ZN4dace4perf6Report4saveEPKcS3_+0x536>
 536:	49 8b b6 b8 00 00 00 	mov    0xb8(%r14),%rsi
 53d:	48 89 df             	mov    %rbx,%rdi
 540:	e8 00 00 00 00       	callq  545 <_ZN4dace4perf6Report4saveEPKcS3_+0x545>
 545:	ba 02 00 00 00       	mov    $0x2,%edx
 54a:	48 89 df             	mov    %rbx,%rdi
 54d:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 554 <_ZN4dace4perf6Report4saveEPKcS3_+0x554>
 554:	e8 00 00 00 00       	callq  559 <_ZN4dace4perf6Report4saveEPKcS3_+0x559>
 559:	49 81 c6 c0 00 00 00 	add    $0xc0,%r14
 560:	4c 39 74 24 28       	cmp    %r14,0x28(%rsp)
 565:	0f 85 e5 fc ff ff    	jne    250 <_ZN4dace4perf6Report4saveEPKcS3_+0x250>
 56b:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
 572:	00 
 573:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 577:	48 8b 9c 04 c8 02 00 	mov    0x2c8(%rsp,%rax,1),%rbx
 57e:	00 
 57f:	48 85 db             	test   %rbx,%rbx
 582:	0f 84 f2 02 00 00    	je     87a <_ZN4dace4perf6Report4saveEPKcS3_+0x87a>
 588:	80 7b 38 00          	cmpb   $0x0,0x38(%rbx)
 58c:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
 591:	74 0a                	je     59d <_ZN4dace4perf6Report4saveEPKcS3_+0x59d>
 593:	8a 43 43             	mov    0x43(%rbx),%al
 596:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
 59b:	eb 1b                	jmp    5b8 <_ZN4dace4perf6Report4saveEPKcS3_+0x5b8>
 59d:	48 89 df             	mov    %rbx,%rdi
 5a0:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
 5a5:	e8 00 00 00 00       	callq  5aa <_ZN4dace4perf6Report4saveEPKcS3_+0x5aa>
 5aa:	48 8b 03             	mov    (%rbx),%rax
 5ad:	48 89 df             	mov    %rbx,%rdi
 5b0:	be 0a 00 00 00       	mov    $0xa,%esi
 5b5:	ff 50 30             	callq  *0x30(%rax)
 5b8:	0f be f0             	movsbl %al,%esi
 5bb:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 5c2:	00 
 5c3:	e8 00 00 00 00       	callq  5c8 <_ZN4dace4perf6Report4saveEPKcS3_+0x5c8>
 5c8:	48 89 c7             	mov    %rax,%rdi
 5cb:	e8 00 00 00 00       	callq  5d0 <_ZN4dace4perf6Report4saveEPKcS3_+0x5d0>
 5d0:	48 89 c3             	mov    %rax,%rbx
 5d3:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 5da <_ZN4dace4perf6Report4saveEPKcS3_+0x5da>
 5da:	ba 04 00 00 00       	mov    $0x4,%edx
 5df:	48 89 c7             	mov    %rax,%rdi
 5e2:	e8 00 00 00 00       	callq  5e7 <_ZN4dace4perf6Report4saveEPKcS3_+0x5e7>
 5e7:	48 8b 03             	mov    (%rbx),%rax
 5ea:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 5ee:	48 8b ac 03 f0 00 00 	mov    0xf0(%rbx,%rax,1),%rbp
 5f5:	00 
 5f6:	48 85 ed             	test   %rbp,%rbp
 5f9:	0f 84 80 02 00 00    	je     87f <_ZN4dace4perf6Report4saveEPKcS3_+0x87f>
 5ff:	80 7d 38 00          	cmpb   $0x0,0x38(%rbp)
 603:	74 05                	je     60a <_ZN4dace4perf6Report4saveEPKcS3_+0x60a>
 605:	8a 45 43             	mov    0x43(%rbp),%al
 608:	eb 17                	jmp    621 <_ZN4dace4perf6Report4saveEPKcS3_+0x621>
 60a:	48 89 ef             	mov    %rbp,%rdi
 60d:	e8 00 00 00 00       	callq  612 <_ZN4dace4perf6Report4saveEPKcS3_+0x612>
 612:	48 8b 45 00          	mov    0x0(%rbp),%rax
 616:	48 89 ef             	mov    %rbp,%rdi
 619:	be 0a 00 00 00       	mov    $0xa,%esi
 61e:	ff 50 30             	callq  *0x30(%rax)
 621:	0f be f0             	movsbl %al,%esi
 624:	48 89 df             	mov    %rbx,%rdi
 627:	e8 00 00 00 00       	callq  62c <_ZN4dace4perf6Report4saveEPKcS3_+0x62c>
 62c:	48 89 c7             	mov    %rax,%rdi
 62f:	e8 00 00 00 00       	callq  634 <_ZN4dace4perf6Report4saveEPKcS3_+0x634>
 634:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 63b <_ZN4dace4perf6Report4saveEPKcS3_+0x63b>
 63b:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 642:	00 
 643:	ba 0f 00 00 00       	mov    $0xf,%edx
 648:	e8 00 00 00 00       	callq  64d <_ZN4dace4perf6Report4saveEPKcS3_+0x64d>
 64d:	4d 85 ff             	test   %r15,%r15
 650:	74 1d                	je     66f <_ZN4dace4perf6Report4saveEPKcS3_+0x66f>
 652:	4c 89 ff             	mov    %r15,%rdi
 655:	e8 00 00 00 00       	callq  65a <_ZN4dace4perf6Report4saveEPKcS3_+0x65a>
 65a:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 661:	00 
 662:	4c 89 fe             	mov    %r15,%rsi
 665:	48 89 c2             	mov    %rax,%rdx
 668:	e8 00 00 00 00       	callq  66d <_ZN4dace4perf6Report4saveEPKcS3_+0x66d>
 66d:	eb 26                	jmp    695 <_ZN4dace4perf6Report4saveEPKcS3_+0x695>
 66f:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
 676:	00 
 677:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 67b:	48 8d 3c 04          	lea    (%rsp,%rax,1),%rdi
 67f:	48 81 c7 d8 01 00 00 	add    $0x1d8,%rdi
 686:	8b b4 04 f8 01 00 00 	mov    0x1f8(%rsp,%rax,1),%esi
 68d:	83 ce 01             	or     $0x1,%esi
 690:	e8 00 00 00 00       	callq  695 <_ZN4dace4perf6Report4saveEPKcS3_+0x695>
 695:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 69c <_ZN4dace4perf6Report4saveEPKcS3_+0x69c>
 69c:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 6a3:	00 
 6a4:	ba 01 00 00 00       	mov    $0x1,%edx
 6a9:	e8 00 00 00 00       	callq  6ae <_ZN4dace4perf6Report4saveEPKcS3_+0x6ae>
 6ae:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
 6b5:	00 
 6b6:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 6ba:	48 8b 9c 04 c8 02 00 	mov    0x2c8(%rsp,%rax,1),%rbx
 6c1:	00 
 6c2:	48 85 db             	test   %rbx,%rbx
 6c5:	0f 84 b9 01 00 00    	je     884 <_ZN4dace4perf6Report4saveEPKcS3_+0x884>
 6cb:	80 7b 38 00          	cmpb   $0x0,0x38(%rbx)
 6cf:	74 05                	je     6d6 <_ZN4dace4perf6Report4saveEPKcS3_+0x6d6>
 6d1:	8a 43 43             	mov    0x43(%rbx),%al
 6d4:	eb 16                	jmp    6ec <_ZN4dace4perf6Report4saveEPKcS3_+0x6ec>
 6d6:	48 89 df             	mov    %rbx,%rdi
 6d9:	e8 00 00 00 00       	callq  6de <_ZN4dace4perf6Report4saveEPKcS3_+0x6de>
 6de:	48 8b 03             	mov    (%rbx),%rax
 6e1:	48 89 df             	mov    %rbx,%rdi
 6e4:	be 0a 00 00 00       	mov    $0xa,%esi
 6e9:	ff 50 30             	callq  *0x30(%rax)
 6ec:	0f be f0             	movsbl %al,%esi
 6ef:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 6f6:	00 
 6f7:	e8 00 00 00 00       	callq  6fc <_ZN4dace4perf6Report4saveEPKcS3_+0x6fc>
 6fc:	48 89 c7             	mov    %rax,%rdi
 6ff:	e8 00 00 00 00       	callq  704 <_ZN4dace4perf6Report4saveEPKcS3_+0x704>
 704:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 70b <_ZN4dace4perf6Report4saveEPKcS3_+0x70b>
 70b:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 712:	00 
 713:	ba 01 00 00 00       	mov    $0x1,%edx
 718:	e8 00 00 00 00       	callq  71d <_ZN4dace4perf6Report4saveEPKcS3_+0x71d>
 71d:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
 724:	00 
 725:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 729:	48 8b 9c 04 c8 02 00 	mov    0x2c8(%rsp,%rax,1),%rbx
 730:	00 
 731:	48 85 db             	test   %rbx,%rbx
 734:	0f 84 4f 01 00 00    	je     889 <_ZN4dace4perf6Report4saveEPKcS3_+0x889>
 73a:	80 7b 38 00          	cmpb   $0x0,0x38(%rbx)
 73e:	74 05                	je     745 <_ZN4dace4perf6Report4saveEPKcS3_+0x745>
 740:	8a 43 43             	mov    0x43(%rbx),%al
 743:	eb 16                	jmp    75b <_ZN4dace4perf6Report4saveEPKcS3_+0x75b>
 745:	48 89 df             	mov    %rbx,%rdi
 748:	e8 00 00 00 00       	callq  74d <_ZN4dace4perf6Report4saveEPKcS3_+0x74d>
 74d:	48 8b 03             	mov    (%rbx),%rax
 750:	48 89 df             	mov    %rbx,%rdi
 753:	be 0a 00 00 00       	mov    $0xa,%esi
 758:	ff 50 30             	callq  *0x30(%rax)
 75b:	0f be f0             	movsbl %al,%esi
 75e:	48 8d bc 24 d8 01 00 	lea    0x1d8(%rsp),%rdi
 765:	00 
 766:	e8 00 00 00 00       	callq  76b <_ZN4dace4perf6Report4saveEPKcS3_+0x76b>
 76b:	48 89 c7             	mov    %rax,%rdi
 76e:	e8 00 00 00 00       	callq  773 <_ZN4dace4perf6Report4saveEPKcS3_+0x773>
 773:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 77a <_ZN4dace4perf6Report4saveEPKcS3_+0x77a>
 77a:	48 8b 08             	mov    (%rax),%rcx
 77d:	48 8b 40 18          	mov    0x18(%rax),%rax
 781:	48 89 8c 24 d8 01 00 	mov    %rcx,0x1d8(%rsp)
 788:	00 
 789:	48 8b 49 e8          	mov    -0x18(%rcx),%rcx
 78d:	48 89 84 0c d8 01 00 	mov    %rax,0x1d8(%rsp,%rcx,1)
 794:	00 
 795:	48 8d bc 24 e0 01 00 	lea    0x1e0(%rsp),%rdi
 79c:	00 
 79d:	e8 00 00 00 00       	callq  7a2 <_ZN4dace4perf6Report4saveEPKcS3_+0x7a2>
 7a2:	48 8d bc 24 d0 02 00 	lea    0x2d0(%rsp),%rdi
 7a9:	00 
 7aa:	e8 00 00 00 00       	callq  7af <_ZN4dace4perf6Report4saveEPKcS3_+0x7af>
 7af:	48 8b 1d 00 00 00 00 	mov    0x0(%rip),%rbx        # 7b6 <_ZN4dace4perf6Report4saveEPKcS3_+0x7b6>
 7b6:	48 8b 03             	mov    (%rbx),%rax
 7b9:	48 8b 4b 40          	mov    0x40(%rbx),%rcx
 7bd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
 7c2:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 7c6:	48 89 4c 04 50       	mov    %rcx,0x50(%rsp,%rax,1)
 7cb:	48 8b 43 48          	mov    0x48(%rbx),%rax
 7cf:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
 7d4:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 7db <_ZN4dace4perf6Report4saveEPKcS3_+0x7db>
 7db:	48 83 c0 10          	add    $0x10,%rax
 7df:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
 7e4:	48 8b bc 24 b0 00 00 	mov    0xb0(%rsp),%rdi
 7eb:	00 
 7ec:	48 8d 84 24 c0 00 00 	lea    0xc0(%rsp),%rax
 7f3:	00 
 7f4:	48 39 c7             	cmp    %rax,%rdi
 7f7:	74 05                	je     7fe <_ZN4dace4perf6Report4saveEPKcS3_+0x7fe>
 7f9:	e8 00 00 00 00       	callq  7fe <_ZN4dace4perf6Report4saveEPKcS3_+0x7fe>
 7fe:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 805 <_ZN4dace4perf6Report4saveEPKcS3_+0x805>
 805:	48 83 c0 10          	add    $0x10,%rax
 809:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
 80e:	48 8d bc 24 a0 00 00 	lea    0xa0(%rsp),%rdi
 815:	00 
 816:	e8 00 00 00 00       	callq  81b <_ZN4dace4perf6Report4saveEPKcS3_+0x81b>
 81b:	48 8b 43 10          	mov    0x10(%rbx),%rax
 81f:	48 8b 4b 18          	mov    0x18(%rbx),%rcx
 823:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
 828:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 82c:	48 89 4c 04 50       	mov    %rcx,0x50(%rsp,%rax,1)
 831:	48 c7 44 24 58 00 00 	movq   $0x0,0x58(%rsp)
 838:	00 00 
 83a:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
 841:	00 
 842:	e8 00 00 00 00       	callq  847 <_ZN4dace4perf6Report4saveEPKcS3_+0x847>
 847:	48 83 3d 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # 84f <_ZN4dace4perf6Report4saveEPKcS3_+0x84f>
 84e:	00 
 84f:	74 08                	je     859 <_ZN4dace4perf6Report4saveEPKcS3_+0x859>
 851:	4c 89 f7             	mov    %r14,%rdi
 854:	e8 00 00 00 00       	callq  859 <_ZN4dace4perf6Report4saveEPKcS3_+0x859>
 859:	48 81 c4 d8 03 00 00 	add    $0x3d8,%rsp
 860:	5b                   	pop    %rbx
 861:	41 5c                	pop    %r12
 863:	41 5d                	pop    %r13
 865:	41 5e                	pop    %r14
 867:	41 5f                	pop    %r15
 869:	5d                   	pop    %rbp
 86a:	c3                   	retq   
 86b:	e8 00 00 00 00       	callq  870 <_ZN4dace4perf6Report4saveEPKcS3_+0x870>
 870:	e8 00 00 00 00       	callq  875 <_ZN4dace4perf6Report4saveEPKcS3_+0x875>
 875:	e8 00 00 00 00       	callq  87a <_ZN4dace4perf6Report4saveEPKcS3_+0x87a>
 87a:	e8 00 00 00 00       	callq  87f <_ZN4dace4perf6Report4saveEPKcS3_+0x87f>
 87f:	e8 00 00 00 00       	callq  884 <_ZN4dace4perf6Report4saveEPKcS3_+0x884>
 884:	e8 00 00 00 00       	callq  889 <_ZN4dace4perf6Report4saveEPKcS3_+0x889>
 889:	e8 00 00 00 00       	callq  88e <_ZN4dace4perf6Report4saveEPKcS3_+0x88e>
 88e:	89 c7                	mov    %eax,%edi
 890:	e8 00 00 00 00       	callq  895 <_ZN4dace4perf6Report4saveEPKcS3_+0x895>
 895:	eb 2f                	jmp    8c6 <_ZN4dace4perf6Report4saveEPKcS3_+0x8c6>
 897:	48 89 c3             	mov    %rax,%rbx
 89a:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
 89f:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
 8a4:	48 39 c7             	cmp    %rax,%rdi
 8a7:	74 61                	je     90a <_ZN4dace4perf6Report4saveEPKcS3_+0x90a>
 8a9:	e8 00 00 00 00       	callq  8ae <_ZN4dace4perf6Report4saveEPKcS3_+0x8ae>
 8ae:	eb 5a                	jmp    90a <_ZN4dace4perf6Report4saveEPKcS3_+0x90a>
 8b0:	48 89 c3             	mov    %rax,%rbx
 8b3:	eb 55                	jmp    90a <_ZN4dace4perf6Report4saveEPKcS3_+0x90a>
 8b5:	48 89 c3             	mov    %rax,%rbx
 8b8:	e9 e6 00 00 00       	jmpq   9a3 <_ZN4dace4perf6Report4saveEPKcS3_+0x9a3>
 8bd:	48 89 c3             	mov    %rax,%rbx
 8c0:	eb 48                	jmp    90a <_ZN4dace4perf6Report4saveEPKcS3_+0x90a>
 8c2:	eb 02                	jmp    8c6 <_ZN4dace4perf6Report4saveEPKcS3_+0x8c6>
 8c4:	eb 00                	jmp    8c6 <_ZN4dace4perf6Report4saveEPKcS3_+0x8c6>
 8c6:	48 89 c3             	mov    %rax,%rbx
 8c9:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 8d0 <_ZN4dace4perf6Report4saveEPKcS3_+0x8d0>
 8d0:	48 8b 08             	mov    (%rax),%rcx
 8d3:	48 8b 40 18          	mov    0x18(%rax),%rax
 8d7:	48 89 8c 24 d8 01 00 	mov    %rcx,0x1d8(%rsp)
 8de:	00 
 8df:	48 8b 49 e8          	mov    -0x18(%rcx),%rcx
 8e3:	48 89 84 0c d8 01 00 	mov    %rax,0x1d8(%rsp,%rcx,1)
 8ea:	00 
 8eb:	48 8d bc 24 e0 01 00 	lea    0x1e0(%rsp),%rdi
 8f2:	00 
 8f3:	e8 00 00 00 00       	callq  8f8 <_ZN4dace4perf6Report4saveEPKcS3_+0x8f8>
 8f8:	48 8d bc 24 d0 02 00 	lea    0x2d0(%rsp),%rdi
 8ff:	00 
 900:	e8 00 00 00 00       	callq  905 <_ZN4dace4perf6Report4saveEPKcS3_+0x905>
 905:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
 90a:	48 8b 2d 00 00 00 00 	mov    0x0(%rip),%rbp        # 911 <_ZN4dace4perf6Report4saveEPKcS3_+0x911>
 911:	48 8b 45 00          	mov    0x0(%rbp),%rax
 915:	48 8b 4d 40          	mov    0x40(%rbp),%rcx
 919:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
 91e:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 922:	48 89 4c 04 50       	mov    %rcx,0x50(%rsp,%rax,1)
 927:	48 8b 45 48          	mov    0x48(%rbp),%rax
 92b:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
 930:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 937 <_ZN4dace4perf6Report4saveEPKcS3_+0x937>
 937:	48 83 c0 10          	add    $0x10,%rax
 93b:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
 940:	48 8b bc 24 b0 00 00 	mov    0xb0(%rsp),%rdi
 947:	00 
 948:	48 8d 84 24 c0 00 00 	lea    0xc0(%rsp),%rax
 94f:	00 
 950:	48 39 c7             	cmp    %rax,%rdi
 953:	74 05                	je     95a <_ZN4dace4perf6Report4saveEPKcS3_+0x95a>
 955:	e8 00 00 00 00       	callq  95a <_ZN4dace4perf6Report4saveEPKcS3_+0x95a>
 95a:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 961 <_ZN4dace4perf6Report4saveEPKcS3_+0x961>
 961:	48 83 c0 10          	add    $0x10,%rax
 965:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
 96a:	48 8d bc 24 a0 00 00 	lea    0xa0(%rsp),%rdi
 971:	00 
 972:	e8 00 00 00 00       	callq  977 <_ZN4dace4perf6Report4saveEPKcS3_+0x977>
 977:	48 8b 45 10          	mov    0x10(%rbp),%rax
 97b:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
 97f:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
 984:	48 8b 40 e8          	mov    -0x18(%rax),%rax
 988:	48 89 4c 04 50       	mov    %rcx,0x50(%rsp,%rax,1)
 98d:	48 c7 44 24 58 00 00 	movq   $0x0,0x58(%rsp)
 994:	00 00 
 996:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
 99d:	00 
 99e:	e8 00 00 00 00       	callq  9a3 <_ZN4dace4perf6Report4saveEPKcS3_+0x9a3>
 9a3:	48 83 3d 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # 9ab <_ZN4dace4perf6Report4saveEPKcS3_+0x9ab>
 9aa:	00 
 9ab:	74 08                	je     9b5 <_ZN4dace4perf6Report4saveEPKcS3_+0x9b5>
 9ad:	4c 89 ff             	mov    %r15,%rdi
 9b0:	e8 00 00 00 00       	callq  9b5 <_ZN4dace4perf6Report4saveEPKcS3_+0x9b5>
 9b5:	48 89 df             	mov    %rbx,%rdi
 9b8:	e8 00 00 00 00       	callq  9bd <.L.str.33+0x868>

Disassembly of section .text._ZN4dace4perf6Report14add_completionEPKcS3_mmmiii:

0000000000000000 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii>:
   0:	55                   	push   %rbp
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 55                	push   %r13
   7:	41 54                	push   %r12
   9:	53                   	push   %rbx
   a:	48 81 ec c8 00 00 00 	sub    $0xc8,%rsp
  11:	4d 89 cc             	mov    %r9,%r12
  14:	4d 89 c5             	mov    %r8,%r13
  17:	48 89 cd             	mov    %rcx,%rbp
  1a:	49 89 d6             	mov    %rdx,%r14
  1d:	49 89 f7             	mov    %rsi,%r15
  20:	48 89 fb             	mov    %rdi,%rbx
  23:	48 83 3d 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # 2b <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x2b>
  2a:	00 
  2b:	74 10                	je     3d <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x3d>
  2d:	48 89 df             	mov    %rbx,%rdi
  30:	e8 00 00 00 00       	callq  35 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x35>
  35:	85 c0                	test   %eax,%eax
  37:	0f 85 33 01 00 00    	jne    170 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x170>
  3d:	8b 84 24 10 01 00 00 	mov    0x110(%rsp),%eax
  44:	8b 8c 24 08 01 00 00 	mov    0x108(%rsp),%ecx
  4b:	8b 94 24 00 01 00 00 	mov    0x100(%rsp),%edx
  52:	c6 44 24 08 58       	movb   $0x58,0x8(%rsp)
  57:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
  5c:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  60:	c5 fc 11 44 24 09    	vmovups %ymm0,0x9(%rsp)
  66:	c5 fc 11 44 24 29    	vmovups %ymm0,0x29(%rsp)
  6c:	c5 fc 11 44 24 33    	vmovups %ymm0,0x33(%rsp)
  72:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
  77:	4c 89 6c 24 60       	mov    %r13,0x60(%rsp)
  7c:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
  81:	89 54 24 70          	mov    %edx,0x70(%rsp)
  85:	89 4c 24 74          	mov    %ecx,0x74(%rsp)
  89:	89 44 24 78          	mov    %eax,0x78(%rsp)
  8d:	c5 fc 11 84 24 80 00 	vmovups %ymm0,0x80(%rsp)
  94:	00 00 
  96:	c5 fc 11 84 24 a0 00 	vmovups %ymm0,0xa0(%rsp)
  9d:	00 00 
  9f:	48 c7 84 24 c0 00 00 	movq   $0x0,0xc0(%rsp)
  a6:	00 00 00 00 00 
  ab:	ba 40 00 00 00       	mov    $0x40,%edx
  b0:	4c 89 fe             	mov    %r15,%rsi
  b3:	c5 f8 77             	vzeroupper 
  b6:	e8 00 00 00 00       	callq  bb <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0xbb>
  bb:	c6 44 24 48 00       	movb   $0x0,0x48(%rsp)
  c0:	ba 0a 00 00 00       	mov    $0xa,%edx
  c5:	48 8d 7c 24 49       	lea    0x49(%rsp),%rdi
  ca:	4c 89 f6             	mov    %r14,%rsi
  cd:	e8 00 00 00 00       	callq  d2 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0xd2>
  d2:	c6 44 24 52 00       	movb   $0x0,0x52(%rsp)
  d7:	48 8b 73 30          	mov    0x30(%rbx),%rsi
  db:	48 3b 73 38          	cmp    0x38(%rbx),%rsi
  df:	74 57                	je     138 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x138>
  e1:	c5 fc 10 84 24 a8 00 	vmovups 0xa8(%rsp),%ymm0
  e8:	00 00 
  ea:	c5 fc 11 86 a0 00 00 	vmovups %ymm0,0xa0(%rsi)
  f1:	00 
  f2:	c5 fc 10 84 24 88 00 	vmovups 0x88(%rsp),%ymm0
  f9:	00 00 
  fb:	c5 fc 11 86 80 00 00 	vmovups %ymm0,0x80(%rsi)
 102:	00 
 103:	c5 fc 10 44 24 08    	vmovups 0x8(%rsp),%ymm0
 109:	c5 fc 10 4c 24 28    	vmovups 0x28(%rsp),%ymm1
 10f:	c5 fc 10 54 24 48    	vmovups 0x48(%rsp),%ymm2
 115:	c5 fc 10 5c 24 68    	vmovups 0x68(%rsp),%ymm3
 11b:	c5 fc 11 5e 60       	vmovups %ymm3,0x60(%rsi)
 120:	c5 fc 11 56 40       	vmovups %ymm2,0x40(%rsi)
 125:	c5 fc 11 4e 20       	vmovups %ymm1,0x20(%rsi)
 12a:	c5 fc 11 06          	vmovups %ymm0,(%rsi)
 12e:	48 81 43 30 c0 00 00 	addq   $0xc0,0x30(%rbx)
 135:	00 
 136:	eb 0e                	jmp    146 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x146>
 138:	48 8d 7b 28          	lea    0x28(%rbx),%rdi
 13c:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
 141:	e8 00 00 00 00       	callq  146 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x146>
 146:	48 83 3d 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # 14e <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x14e>
 14d:	00 
 14e:	74 0b                	je     15b <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x15b>
 150:	48 89 df             	mov    %rbx,%rdi
 153:	c5 f8 77             	vzeroupper 
 156:	e8 00 00 00 00       	callq  15b <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x15b>
 15b:	48 81 c4 c8 00 00 00 	add    $0xc8,%rsp
 162:	5b                   	pop    %rbx
 163:	41 5c                	pop    %r12
 165:	41 5d                	pop    %r13
 167:	41 5e                	pop    %r14
 169:	41 5f                	pop    %r15
 16b:	5d                   	pop    %rbp
 16c:	c5 f8 77             	vzeroupper 
 16f:	c3                   	retq   
 170:	89 c7                	mov    %eax,%edi
 172:	e8 00 00 00 00       	callq  177 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x177>
 177:	48 89 c5             	mov    %rax,%rbp
 17a:	48 83 3d 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # 182 <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x182>
 181:	00 
 182:	74 08                	je     18c <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x18c>
 184:	48 89 df             	mov    %rbx,%rdi
 187:	e8 00 00 00 00       	callq  18c <_ZN4dace4perf6Report14add_completionEPKcS3_mmmiii+0x18c>
 18c:	48 89 ef             	mov    %rbp,%rdi
 18f:	e8 00 00 00 00       	callq  194 <.L.str.33+0x3f>

Disassembly of section .text.__clang_call_terminate:

0000000000000000 <__clang_call_terminate>:
   0:	50                   	push   %rax
   1:	e8 00 00 00 00       	callq  6 <__clang_call_terminate+0x6>
   6:	e8 00 00 00 00       	callq  b <__clang_call_terminate+0xb>

Disassembly of section .text._ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_:

0000000000000000 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_>:
   0:	55                   	push   %rbp
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 55                	push   %r13
   7:	41 54                	push   %r12
   9:	53                   	push   %rbx
   a:	48 83 ec 18          	sub    $0x18,%rsp
   e:	48 8b 1f             	mov    (%rdi),%rbx
  11:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
  15:	4c 89 e8             	mov    %r13,%rax
  18:	48 29 d8             	sub    %rbx,%rax
  1b:	48 b9 80 ff ff ff ff 	movabs $0x7fffffffffffff80,%rcx
  22:	ff ff 7f 
  25:	48 39 c8             	cmp    %rcx,%rax
  28:	0f 84 72 01 00 00    	je     1a0 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x1a0>
  2e:	48 89 d5             	mov    %rdx,%rbp
  31:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
  36:	48 89 c1             	mov    %rax,%rcx
  39:	48 c1 f9 06          	sar    $0x6,%rcx
  3d:	48 bf ab aa aa aa aa 	movabs $0xaaaaaaaaaaaaaaab,%rdi
  44:	aa aa aa 
  47:	48 0f af cf          	imul   %rdi,%rcx
  4b:	48 85 c0             	test   %rax,%rax
  4e:	b8 01 00 00 00       	mov    $0x1,%eax
  53:	48 0f 45 c1          	cmovne %rcx,%rax
  57:	4c 8d 34 08          	lea    (%rax,%rcx,1),%r14
  5b:	48 ba aa aa aa aa aa 	movabs $0xaaaaaaaaaaaaaa,%rdx
  62:	aa aa 00 
  65:	49 39 d6             	cmp    %rdx,%r14
  68:	4c 0f 47 f2          	cmova  %rdx,%r14
  6c:	48 01 c8             	add    %rcx,%rax
  6f:	4c 0f 42 f2          	cmovb  %rdx,%r14
  73:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  78:	49 89 f4             	mov    %rsi,%r12
  7b:	48 89 1c 24          	mov    %rbx,(%rsp)
  7f:	49 29 dc             	sub    %rbx,%r12
  82:	4d 89 e7             	mov    %r12,%r15
  85:	49 c1 ff 06          	sar    $0x6,%r15
  89:	4c 0f af ff          	imul   %rdi,%r15
  8d:	4d 85 f6             	test   %r14,%r14
  90:	74 15                	je     a7 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0xa7>
  92:	4c 89 f0             	mov    %r14,%rax
  95:	48 c1 e0 06          	shl    $0x6,%rax
  99:	48 8d 3c 40          	lea    (%rax,%rax,2),%rdi
  9d:	e8 00 00 00 00       	callq  a2 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0xa2>
  a2:	48 89 c3             	mov    %rax,%rbx
  a5:	eb 02                	jmp    a9 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0xa9>
  a7:	31 db                	xor    %ebx,%ebx
  a9:	4b 8d 04 7f          	lea    (%r15,%r15,2),%rax
  ad:	48 c1 e0 06          	shl    $0x6,%rax
  b1:	c5 fc 10 85 a0 00 00 	vmovups 0xa0(%rbp),%ymm0
  b8:	00 
  b9:	c5 fc 11 84 03 a0 00 	vmovups %ymm0,0xa0(%rbx,%rax,1)
  c0:	00 00 
  c2:	c5 fc 10 85 80 00 00 	vmovups 0x80(%rbp),%ymm0
  c9:	00 
  ca:	c5 fc 11 84 03 80 00 	vmovups %ymm0,0x80(%rbx,%rax,1)
  d1:	00 00 
  d3:	c5 fc 10 45 00       	vmovups 0x0(%rbp),%ymm0
  d8:	c5 fc 10 4d 20       	vmovups 0x20(%rbp),%ymm1
  dd:	c5 fc 10 55 40       	vmovups 0x40(%rbp),%ymm2
  e2:	c5 fc 10 5d 60       	vmovups 0x60(%rbp),%ymm3
  e7:	c5 fc 11 5c 03 60    	vmovups %ymm3,0x60(%rbx,%rax,1)
  ed:	c5 fc 11 54 03 40    	vmovups %ymm2,0x40(%rbx,%rax,1)
  f3:	4c 8d 3c 03          	lea    (%rbx,%rax,1),%r15
  f7:	c5 fc 11 4c 03 20    	vmovups %ymm1,0x20(%rbx,%rax,1)
  fd:	c5 fc 11 04 03       	vmovups %ymm0,(%rbx,%rax,1)
 102:	4d 85 e4             	test   %r12,%r12
 105:	7e 12                	jle    119 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x119>
 107:	48 89 df             	mov    %rbx,%rdi
 10a:	48 8b 34 24          	mov    (%rsp),%rsi
 10e:	4c 89 e2             	mov    %r12,%rdx
 111:	c5 f8 77             	vzeroupper 
 114:	e8 00 00 00 00       	callq  119 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x119>
 119:	49 81 c7 c0 00 00 00 	add    $0xc0,%r15
 120:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 125:	49 29 f5             	sub    %rsi,%r13
 128:	4c 89 ed             	mov    %r13,%rbp
 12b:	48 c1 fd 06          	sar    $0x6,%rbp
 12f:	48 b8 ab aa aa aa aa 	movabs $0xaaaaaaaaaaaaaaab,%rax
 136:	aa aa aa 
 139:	48 0f af e8          	imul   %rax,%rbp
 13d:	4d 85 ed             	test   %r13,%r13
 140:	7e 0e                	jle    150 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x150>
 142:	4c 89 ff             	mov    %r15,%rdi
 145:	4c 89 ea             	mov    %r13,%rdx
 148:	c5 f8 77             	vzeroupper 
 14b:	e8 00 00 00 00       	callq  150 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x150>
 150:	48 8d 04 6d 00 00 00 	lea    0x0(,%rbp,2),%rax
 157:	00 
 158:	48 01 e8             	add    %rbp,%rax
 15b:	48 c1 e0 06          	shl    $0x6,%rax
 15f:	49 01 c7             	add    %rax,%r15
 162:	48 8b 3c 24          	mov    (%rsp),%rdi
 166:	48 85 ff             	test   %rdi,%rdi
 169:	74 08                	je     173 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x173>
 16b:	c5 f8 77             	vzeroupper 
 16e:	e8 00 00 00 00       	callq  173 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x173>
 173:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
 178:	48 89 19             	mov    %rbx,(%rcx)
 17b:	4c 89 79 08          	mov    %r15,0x8(%rcx)
 17f:	4b 8d 04 76          	lea    (%r14,%r14,2),%rax
 183:	48 c1 e0 06          	shl    $0x6,%rax
 187:	48 01 d8             	add    %rbx,%rax
 18a:	48 89 41 10          	mov    %rax,0x10(%rcx)
 18e:	48 83 c4 18          	add    $0x18,%rsp
 192:	5b                   	pop    %rbx
 193:	41 5c                	pop    %r12
 195:	41 5d                	pop    %r13
 197:	41 5e                	pop    %r14
 199:	41 5f                	pop    %r15
 19b:	5d                   	pop    %rbp
 19c:	c5 f8 77             	vzeroupper 
 19f:	c3                   	retq   
 1a0:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 1a7 <_ZNSt6vectorIN4dace4perf10TraceEventESaIS2_EE17_M_realloc_insertIJRKS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_+0x1a7>
 1a7:	e8 00 00 00 00       	callq  1ac <.L.str.33+0x57>
