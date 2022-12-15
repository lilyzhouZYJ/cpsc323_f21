
bomb:     file format elf32-i386


Disassembly of section .init:

00001000 <_init>:
    1000:	f3 0f 1e fb          	endbr32 
    1004:	53                   	push   %ebx
    1005:	83 ec 08             	sub    $0x8,%esp
    1008:	e8 23 04 00 00       	call   1430 <__x86.get_pc_thunk.bx>
    100d:	81 c3 4b 4f 00 00    	add    $0x4f4b,%ebx
    1013:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
    1019:	85 c0                	test   %eax,%eax
    101b:	74 02                	je     101f <_init+0x1f>
    101d:	ff d0                	call   *%eax
    101f:	83 c4 08             	add    $0x8,%esp
    1022:	5b                   	pop    %ebx
    1023:	c3                   	ret    

Disassembly of section .plt:

00001030 <.plt>:
    1030:	ff b3 04 00 00 00    	pushl  0x4(%ebx)
    1036:	ff a3 08 00 00 00    	jmp    *0x8(%ebx)
    103c:	0f 1f 40 00          	nopl   0x0(%eax)
    1040:	f3 0f 1e fb          	endbr32 
    1044:	68 00 00 00 00       	push   $0x0
    1049:	e9 e2 ff ff ff       	jmp    1030 <.plt>
    104e:	66 90                	xchg   %ax,%ax
    1050:	f3 0f 1e fb          	endbr32 
    1054:	68 08 00 00 00       	push   $0x8
    1059:	e9 d2 ff ff ff       	jmp    1030 <.plt>
    105e:	66 90                	xchg   %ax,%ax
    1060:	f3 0f 1e fb          	endbr32 
    1064:	68 10 00 00 00       	push   $0x10
    1069:	e9 c2 ff ff ff       	jmp    1030 <.plt>
    106e:	66 90                	xchg   %ax,%ax
    1070:	f3 0f 1e fb          	endbr32 
    1074:	68 18 00 00 00       	push   $0x18
    1079:	e9 b2 ff ff ff       	jmp    1030 <.plt>
    107e:	66 90                	xchg   %ax,%ax
    1080:	f3 0f 1e fb          	endbr32 
    1084:	68 20 00 00 00       	push   $0x20
    1089:	e9 a2 ff ff ff       	jmp    1030 <.plt>
    108e:	66 90                	xchg   %ax,%ax
    1090:	f3 0f 1e fb          	endbr32 
    1094:	68 28 00 00 00       	push   $0x28
    1099:	e9 92 ff ff ff       	jmp    1030 <.plt>
    109e:	66 90                	xchg   %ax,%ax
    10a0:	f3 0f 1e fb          	endbr32 
    10a4:	68 30 00 00 00       	push   $0x30
    10a9:	e9 82 ff ff ff       	jmp    1030 <.plt>
    10ae:	66 90                	xchg   %ax,%ax
    10b0:	f3 0f 1e fb          	endbr32 
    10b4:	68 38 00 00 00       	push   $0x38
    10b9:	e9 72 ff ff ff       	jmp    1030 <.plt>
    10be:	66 90                	xchg   %ax,%ax
    10c0:	f3 0f 1e fb          	endbr32 
    10c4:	68 40 00 00 00       	push   $0x40
    10c9:	e9 62 ff ff ff       	jmp    1030 <.plt>
    10ce:	66 90                	xchg   %ax,%ax
    10d0:	f3 0f 1e fb          	endbr32 
    10d4:	68 48 00 00 00       	push   $0x48
    10d9:	e9 52 ff ff ff       	jmp    1030 <.plt>
    10de:	66 90                	xchg   %ax,%ax
    10e0:	f3 0f 1e fb          	endbr32 
    10e4:	68 50 00 00 00       	push   $0x50
    10e9:	e9 42 ff ff ff       	jmp    1030 <.plt>
    10ee:	66 90                	xchg   %ax,%ax
    10f0:	f3 0f 1e fb          	endbr32 
    10f4:	68 58 00 00 00       	push   $0x58
    10f9:	e9 32 ff ff ff       	jmp    1030 <.plt>
    10fe:	66 90                	xchg   %ax,%ax
    1100:	f3 0f 1e fb          	endbr32 
    1104:	68 60 00 00 00       	push   $0x60
    1109:	e9 22 ff ff ff       	jmp    1030 <.plt>
    110e:	66 90                	xchg   %ax,%ax
    1110:	f3 0f 1e fb          	endbr32 
    1114:	68 68 00 00 00       	push   $0x68
    1119:	e9 12 ff ff ff       	jmp    1030 <.plt>
    111e:	66 90                	xchg   %ax,%ax
    1120:	f3 0f 1e fb          	endbr32 
    1124:	68 70 00 00 00       	push   $0x70
    1129:	e9 02 ff ff ff       	jmp    1030 <.plt>
    112e:	66 90                	xchg   %ax,%ax
    1130:	f3 0f 1e fb          	endbr32 
    1134:	68 78 00 00 00       	push   $0x78
    1139:	e9 f2 fe ff ff       	jmp    1030 <.plt>
    113e:	66 90                	xchg   %ax,%ax
    1140:	f3 0f 1e fb          	endbr32 
    1144:	68 80 00 00 00       	push   $0x80
    1149:	e9 e2 fe ff ff       	jmp    1030 <.plt>
    114e:	66 90                	xchg   %ax,%ax
    1150:	f3 0f 1e fb          	endbr32 
    1154:	68 88 00 00 00       	push   $0x88
    1159:	e9 d2 fe ff ff       	jmp    1030 <.plt>
    115e:	66 90                	xchg   %ax,%ax
    1160:	f3 0f 1e fb          	endbr32 
    1164:	68 90 00 00 00       	push   $0x90
    1169:	e9 c2 fe ff ff       	jmp    1030 <.plt>
    116e:	66 90                	xchg   %ax,%ax
    1170:	f3 0f 1e fb          	endbr32 
    1174:	68 98 00 00 00       	push   $0x98
    1179:	e9 b2 fe ff ff       	jmp    1030 <.plt>
    117e:	66 90                	xchg   %ax,%ax
    1180:	f3 0f 1e fb          	endbr32 
    1184:	68 a0 00 00 00       	push   $0xa0
    1189:	e9 a2 fe ff ff       	jmp    1030 <.plt>
    118e:	66 90                	xchg   %ax,%ax
    1190:	f3 0f 1e fb          	endbr32 
    1194:	68 a8 00 00 00       	push   $0xa8
    1199:	e9 92 fe ff ff       	jmp    1030 <.plt>
    119e:	66 90                	xchg   %ax,%ax
    11a0:	f3 0f 1e fb          	endbr32 
    11a4:	68 b0 00 00 00       	push   $0xb0
    11a9:	e9 82 fe ff ff       	jmp    1030 <.plt>
    11ae:	66 90                	xchg   %ax,%ax
    11b0:	f3 0f 1e fb          	endbr32 
    11b4:	68 b8 00 00 00       	push   $0xb8
    11b9:	e9 72 fe ff ff       	jmp    1030 <.plt>
    11be:	66 90                	xchg   %ax,%ax
    11c0:	f3 0f 1e fb          	endbr32 
    11c4:	68 c0 00 00 00       	push   $0xc0
    11c9:	e9 62 fe ff ff       	jmp    1030 <.plt>
    11ce:	66 90                	xchg   %ax,%ax
    11d0:	f3 0f 1e fb          	endbr32 
    11d4:	68 c8 00 00 00       	push   $0xc8
    11d9:	e9 52 fe ff ff       	jmp    1030 <.plt>
    11de:	66 90                	xchg   %ax,%ax
    11e0:	f3 0f 1e fb          	endbr32 
    11e4:	68 d0 00 00 00       	push   $0xd0
    11e9:	e9 42 fe ff ff       	jmp    1030 <.plt>
    11ee:	66 90                	xchg   %ax,%ax
    11f0:	f3 0f 1e fb          	endbr32 
    11f4:	68 d8 00 00 00       	push   $0xd8
    11f9:	e9 32 fe ff ff       	jmp    1030 <.plt>
    11fe:	66 90                	xchg   %ax,%ax
    1200:	f3 0f 1e fb          	endbr32 
    1204:	68 e0 00 00 00       	push   $0xe0
    1209:	e9 22 fe ff ff       	jmp    1030 <.plt>
    120e:	66 90                	xchg   %ax,%ax

Disassembly of section .plt.got:

00001210 <__cxa_finalize@plt>:
    1210:	f3 0f 1e fb          	endbr32 
    1214:	ff a3 8c 00 00 00    	jmp    *0x8c(%ebx)
    121a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

Disassembly of section .plt.sec:

00001220 <read@plt>:
    1220:	f3 0f 1e fb          	endbr32 
    1224:	ff a3 0c 00 00 00    	jmp    *0xc(%ebx)
    122a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001230 <fflush@plt>:
    1230:	f3 0f 1e fb          	endbr32 
    1234:	ff a3 10 00 00 00    	jmp    *0x10(%ebx)
    123a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001240 <fgets@plt>:
    1240:	f3 0f 1e fb          	endbr32 
    1244:	ff a3 14 00 00 00    	jmp    *0x14(%ebx)
    124a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001250 <signal@plt>:
    1250:	f3 0f 1e fb          	endbr32 
    1254:	ff a3 18 00 00 00    	jmp    *0x18(%ebx)
    125a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001260 <sleep@plt>:
    1260:	f3 0f 1e fb          	endbr32 
    1264:	ff a3 1c 00 00 00    	jmp    *0x1c(%ebx)
    126a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001270 <alarm@plt>:
    1270:	f3 0f 1e fb          	endbr32 
    1274:	ff a3 20 00 00 00    	jmp    *0x20(%ebx)
    127a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001280 <__stack_chk_fail@plt>:
    1280:	f3 0f 1e fb          	endbr32 
    1284:	ff a3 24 00 00 00    	jmp    *0x24(%ebx)
    128a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001290 <strcpy@plt>:
    1290:	f3 0f 1e fb          	endbr32 
    1294:	ff a3 28 00 00 00    	jmp    *0x28(%ebx)
    129a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000012a0 <gethostname@plt>:
    12a0:	f3 0f 1e fb          	endbr32 
    12a4:	ff a3 2c 00 00 00    	jmp    *0x2c(%ebx)
    12aa:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000012b0 <getenv@plt>:
    12b0:	f3 0f 1e fb          	endbr32 
    12b4:	ff a3 30 00 00 00    	jmp    *0x30(%ebx)
    12ba:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000012c0 <malloc@plt>:
    12c0:	f3 0f 1e fb          	endbr32 
    12c4:	ff a3 34 00 00 00    	jmp    *0x34(%ebx)
    12ca:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000012d0 <puts@plt>:
    12d0:	f3 0f 1e fb          	endbr32 
    12d4:	ff a3 38 00 00 00    	jmp    *0x38(%ebx)
    12da:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000012e0 <__memmove_chk@plt>:
    12e0:	f3 0f 1e fb          	endbr32 
    12e4:	ff a3 3c 00 00 00    	jmp    *0x3c(%ebx)
    12ea:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000012f0 <exit@plt>:
    12f0:	f3 0f 1e fb          	endbr32 
    12f4:	ff a3 40 00 00 00    	jmp    *0x40(%ebx)
    12fa:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001300 <__libc_start_main@plt>:
    1300:	f3 0f 1e fb          	endbr32 
    1304:	ff a3 44 00 00 00    	jmp    *0x44(%ebx)
    130a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001310 <write@plt>:
    1310:	f3 0f 1e fb          	endbr32 
    1314:	ff a3 48 00 00 00    	jmp    *0x48(%ebx)
    131a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001320 <strcasecmp@plt>:
    1320:	f3 0f 1e fb          	endbr32 
    1324:	ff a3 4c 00 00 00    	jmp    *0x4c(%ebx)
    132a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001330 <__isoc99_sscanf@plt>:
    1330:	f3 0f 1e fb          	endbr32 
    1334:	ff a3 50 00 00 00    	jmp    *0x50(%ebx)
    133a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001340 <fopen@plt>:
    1340:	f3 0f 1e fb          	endbr32 
    1344:	ff a3 54 00 00 00    	jmp    *0x54(%ebx)
    134a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001350 <__errno_location@plt>:
    1350:	f3 0f 1e fb          	endbr32 
    1354:	ff a3 58 00 00 00    	jmp    *0x58(%ebx)
    135a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001360 <__printf_chk@plt>:
    1360:	f3 0f 1e fb          	endbr32 
    1364:	ff a3 5c 00 00 00    	jmp    *0x5c(%ebx)
    136a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001370 <socket@plt>:
    1370:	f3 0f 1e fb          	endbr32 
    1374:	ff a3 60 00 00 00    	jmp    *0x60(%ebx)
    137a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001380 <__fprintf_chk@plt>:
    1380:	f3 0f 1e fb          	endbr32 
    1384:	ff a3 64 00 00 00    	jmp    *0x64(%ebx)
    138a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

00001390 <gethostbyname@plt>:
    1390:	f3 0f 1e fb          	endbr32 
    1394:	ff a3 68 00 00 00    	jmp    *0x68(%ebx)
    139a:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000013a0 <strtol@plt>:
    13a0:	f3 0f 1e fb          	endbr32 
    13a4:	ff a3 6c 00 00 00    	jmp    *0x6c(%ebx)
    13aa:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000013b0 <connect@plt>:
    13b0:	f3 0f 1e fb          	endbr32 
    13b4:	ff a3 70 00 00 00    	jmp    *0x70(%ebx)
    13ba:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000013c0 <close@plt>:
    13c0:	f3 0f 1e fb          	endbr32 
    13c4:	ff a3 74 00 00 00    	jmp    *0x74(%ebx)
    13ca:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000013d0 <__ctype_b_loc@plt>:
    13d0:	f3 0f 1e fb          	endbr32 
    13d4:	ff a3 78 00 00 00    	jmp    *0x78(%ebx)
    13da:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

000013e0 <__sprintf_chk@plt>:
    13e0:	f3 0f 1e fb          	endbr32 
    13e4:	ff a3 7c 00 00 00    	jmp    *0x7c(%ebx)
    13ea:	66 0f 1f 44 00 00    	nopw   0x0(%eax,%eax,1)

Disassembly of section .text:

000013f0 <_start>:
    13f0:	f3 0f 1e fb          	endbr32 
    13f4:	31 ed                	xor    %ebp,%ebp
    13f6:	5e                   	pop    %esi
    13f7:	89 e1                	mov    %esp,%ecx
    13f9:	83 e4 f0             	and    $0xfffffff0,%esp
    13fc:	50                   	push   %eax
    13fd:	54                   	push   %esp
    13fe:	52                   	push   %edx
    13ff:	e8 22 00 00 00       	call   1426 <_start+0x36>
    1404:	81 c3 54 4b 00 00    	add    $0x4b54,%ebx
    140a:	8d 83 d8 cf ff ff    	lea    -0x3028(%ebx),%eax
    1410:	50                   	push   %eax
    1411:	8d 83 68 cf ff ff    	lea    -0x3098(%ebx),%eax
    1417:	50                   	push   %eax
    1418:	51                   	push   %ecx
    1419:	56                   	push   %esi
    141a:	ff b3 a0 00 00 00    	pushl  0xa0(%ebx)
    1420:	e8 db fe ff ff       	call   1300 <__libc_start_main@plt>
    1425:	f4                   	hlt    
    1426:	8b 1c 24             	mov    (%esp),%ebx
    1429:	c3                   	ret    
    142a:	66 90                	xchg   %ax,%ax
    142c:	66 90                	xchg   %ax,%ax
    142e:	66 90                	xchg   %ax,%ax

00001430 <__x86.get_pc_thunk.bx>:
    1430:	8b 1c 24             	mov    (%esp),%ebx
    1433:	c3                   	ret    
    1434:	66 90                	xchg   %ax,%ax
    1436:	66 90                	xchg   %ax,%ax
    1438:	66 90                	xchg   %ax,%ax
    143a:	66 90                	xchg   %ax,%ax
    143c:	66 90                	xchg   %ax,%ax
    143e:	66 90                	xchg   %ax,%ax

00001440 <deregister_tm_clones>:
    1440:	e8 e4 00 00 00       	call   1529 <__x86.get_pc_thunk.dx>
    1445:	81 c2 13 4b 00 00    	add    $0x4b13,%edx
    144b:	8d 8a e8 07 00 00    	lea    0x7e8(%edx),%ecx
    1451:	8d 82 e8 07 00 00    	lea    0x7e8(%edx),%eax
    1457:	39 c8                	cmp    %ecx,%eax
    1459:	74 1d                	je     1478 <deregister_tm_clones+0x38>
    145b:	8b 82 80 00 00 00    	mov    0x80(%edx),%eax
    1461:	85 c0                	test   %eax,%eax
    1463:	74 13                	je     1478 <deregister_tm_clones+0x38>
    1465:	55                   	push   %ebp
    1466:	89 e5                	mov    %esp,%ebp
    1468:	83 ec 14             	sub    $0x14,%esp
    146b:	51                   	push   %ecx
    146c:	ff d0                	call   *%eax
    146e:	83 c4 10             	add    $0x10,%esp
    1471:	c9                   	leave  
    1472:	c3                   	ret    
    1473:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1477:	90                   	nop
    1478:	c3                   	ret    
    1479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001480 <register_tm_clones>:
    1480:	e8 a4 00 00 00       	call   1529 <__x86.get_pc_thunk.dx>
    1485:	81 c2 d3 4a 00 00    	add    $0x4ad3,%edx
    148b:	55                   	push   %ebp
    148c:	89 e5                	mov    %esp,%ebp
    148e:	53                   	push   %ebx
    148f:	8d 8a e8 07 00 00    	lea    0x7e8(%edx),%ecx
    1495:	8d 82 e8 07 00 00    	lea    0x7e8(%edx),%eax
    149b:	83 ec 04             	sub    $0x4,%esp
    149e:	29 c8                	sub    %ecx,%eax
    14a0:	89 c3                	mov    %eax,%ebx
    14a2:	c1 e8 1f             	shr    $0x1f,%eax
    14a5:	c1 fb 02             	sar    $0x2,%ebx
    14a8:	01 d8                	add    %ebx,%eax
    14aa:	d1 f8                	sar    %eax
    14ac:	74 14                	je     14c2 <register_tm_clones+0x42>
    14ae:	8b 92 a4 00 00 00    	mov    0xa4(%edx),%edx
    14b4:	85 d2                	test   %edx,%edx
    14b6:	74 0a                	je     14c2 <register_tm_clones+0x42>
    14b8:	83 ec 08             	sub    $0x8,%esp
    14bb:	50                   	push   %eax
    14bc:	51                   	push   %ecx
    14bd:	ff d2                	call   *%edx
    14bf:	83 c4 10             	add    $0x10,%esp
    14c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14c5:	c9                   	leave  
    14c6:	c3                   	ret    
    14c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14ce:	66 90                	xchg   %ax,%ax

000014d0 <__do_global_dtors_aux>:
    14d0:	f3 0f 1e fb          	endbr32 
    14d4:	55                   	push   %ebp
    14d5:	89 e5                	mov    %esp,%ebp
    14d7:	53                   	push   %ebx
    14d8:	e8 53 ff ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    14dd:	81 c3 7b 4a 00 00    	add    $0x4a7b,%ebx
    14e3:	83 ec 04             	sub    $0x4,%esp
    14e6:	80 bb e8 07 00 00 00 	cmpb   $0x0,0x7e8(%ebx)
    14ed:	75 27                	jne    1516 <__do_global_dtors_aux+0x46>
    14ef:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
    14f5:	85 c0                	test   %eax,%eax
    14f7:	74 11                	je     150a <__do_global_dtors_aux+0x3a>
    14f9:	83 ec 0c             	sub    $0xc,%esp
    14fc:	ff b3 ac 00 00 00    	pushl  0xac(%ebx)
    1502:	e8 09 fd ff ff       	call   1210 <__cxa_finalize@plt>
    1507:	83 c4 10             	add    $0x10,%esp
    150a:	e8 31 ff ff ff       	call   1440 <deregister_tm_clones>
    150f:	c6 83 e8 07 00 00 01 	movb   $0x1,0x7e8(%ebx)
    1516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1519:	c9                   	leave  
    151a:	c3                   	ret    
    151b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    151f:	90                   	nop

00001520 <frame_dummy>:
    1520:	f3 0f 1e fb          	endbr32 
    1524:	e9 57 ff ff ff       	jmp    1480 <register_tm_clones>

00001529 <__x86.get_pc_thunk.dx>:
    1529:	8b 14 24             	mov    (%esp),%edx
    152c:	c3                   	ret    

0000152d <main>:
    152d:	f3 0f 1e fb          	endbr32 
    1531:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1535:	83 e4 f0             	and    $0xfffffff0,%esp
    1538:	ff 71 fc             	pushl  -0x4(%ecx)
    153b:	55                   	push   %ebp
    153c:	89 e5                	mov    %esp,%ebp
    153e:	56                   	push   %esi
    153f:	53                   	push   %ebx
    1540:	51                   	push   %ecx
    1541:	83 ec 0c             	sub    $0xc,%esp
    1544:	e8 e7 fe ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1549:	81 c3 0f 4a 00 00    	add    $0x4a0f,%ebx
    154f:	8b 01                	mov    (%ecx),%eax
    1551:	8b 71 04             	mov    0x4(%ecx),%esi
    1554:	83 f8 01             	cmp    $0x1,%eax
    1557:	0f 84 83 01 00 00    	je     16e0 <main+0x1b3>
    155d:	83 f8 02             	cmp    $0x2,%eax
    1560:	0f 85 ae 01 00 00    	jne    1714 <main+0x1e7>
    1566:	83 ec 08             	sub    $0x8,%esp
    1569:	8d 83 b0 d0 ff ff    	lea    -0x2f50(%ebx),%eax
    156f:	50                   	push   %eax
    1570:	ff 76 04             	pushl  0x4(%esi)
    1573:	e8 c8 fd ff ff       	call   1340 <fopen@plt>
    1578:	8d 93 f0 07 00 00    	lea    0x7f0(%ebx),%edx
    157e:	89 02                	mov    %eax,(%edx)
    1580:	83 c4 10             	add    $0x10,%esp
    1583:	85 c0                	test   %eax,%eax
    1585:	0f 84 6a 01 00 00    	je     16f5 <main+0x1c8>
    158b:	e8 8a 08 00 00       	call   1e1a <initialize_bomb>
    1590:	83 ec 0c             	sub    $0xc,%esp
    1593:	8d 83 40 d1 ff ff    	lea    -0x2ec0(%ebx),%eax
    1599:	50                   	push   %eax
    159a:	e8 31 fd ff ff       	call   12d0 <puts@plt>
    159f:	8d 83 7c d1 ff ff    	lea    -0x2e84(%ebx),%eax
    15a5:	89 04 24             	mov    %eax,(%esp)
    15a8:	e8 23 fd ff ff       	call   12d0 <puts@plt>
    15ad:	e8 a8 0b 00 00       	call   215a <read_line>
    15b2:	89 04 24             	mov    %eax,(%esp)
    15b5:	e8 79 01 00 00       	call   1733 <phase_1>
    15ba:	e8 c4 0c 00 00       	call   2283 <phase_defused>
    15bf:	8d 83 a8 d1 ff ff    	lea    -0x2e58(%ebx),%eax
    15c5:	89 04 24             	mov    %eax,(%esp)
    15c8:	e8 03 fd ff ff       	call   12d0 <puts@plt>
    15cd:	e8 88 0b 00 00       	call   215a <read_line>
    15d2:	89 04 24             	mov    %eax,(%esp)
    15d5:	e8 cc 01 00 00       	call   17a6 <phase_2>
    15da:	e8 a4 0c 00 00       	call   2283 <phase_defused>
    15df:	8d 83 e9 d0 ff ff    	lea    -0x2f17(%ebx),%eax
    15e5:	89 04 24             	mov    %eax,(%esp)
    15e8:	e8 e3 fc ff ff       	call   12d0 <puts@plt>
    15ed:	e8 68 0b 00 00       	call   215a <read_line>
    15f2:	89 04 24             	mov    %eax,(%esp)
    15f5:	e8 e2 01 00 00       	call   17dc <phase_3>
    15fa:	e8 84 0c 00 00       	call   2283 <phase_defused>
    15ff:	8d 83 07 d1 ff ff    	lea    -0x2ef9(%ebx),%eax
    1605:	89 04 24             	mov    %eax,(%esp)
    1608:	e8 c3 fc ff ff       	call   12d0 <puts@plt>
    160d:	e8 48 0b 00 00       	call   215a <read_line>
    1612:	89 04 24             	mov    %eax,(%esp)
    1615:	e8 67 02 00 00       	call   1881 <phase_4>
    161a:	e8 64 0c 00 00       	call   2283 <phase_defused>
    161f:	8d 83 d4 d1 ff ff    	lea    -0x2e2c(%ebx),%eax
    1625:	89 04 24             	mov    %eax,(%esp)
    1628:	e8 a3 fc ff ff       	call   12d0 <puts@plt>
    162d:	e8 28 0b 00 00       	call   215a <read_line>
    1632:	89 04 24             	mov    %eax,(%esp)
    1635:	e8 c7 02 00 00       	call   1901 <phase_5>
    163a:	e8 44 0c 00 00       	call   2283 <phase_defused>
    163f:	8d 83 18 d1 ff ff    	lea    -0x2ee8(%ebx),%eax
    1645:	89 04 24             	mov    %eax,(%esp)
    1648:	e8 83 fc ff ff       	call   12d0 <puts@plt>
    164d:	e8 08 0b 00 00       	call   215a <read_line>
    1652:	89 04 24             	mov    %eax,(%esp)
    1655:	e8 cd 03 00 00       	call   1a27 <phase_6>
    165a:	e8 24 0c 00 00       	call   2283 <phase_defused>
    165f:	8d 83 f8 d1 ff ff    	lea    -0x2e08(%ebx),%eax
    1665:	89 04 24             	mov    %eax,(%esp)
    1668:	e8 63 fc ff ff       	call   12d0 <puts@plt>
    166d:	e8 e8 0a 00 00       	call   215a <read_line>
    1672:	89 04 24             	mov    %eax,(%esp)
    1675:	e8 35 04 00 00       	call   1aaf <phase_7>
    167a:	e8 04 0c 00 00       	call   2283 <phase_defused>
    167f:	8d 83 18 d2 ff ff    	lea    -0x2de8(%ebx),%eax
    1685:	89 04 24             	mov    %eax,(%esp)
    1688:	e8 43 fc ff ff       	call   12d0 <puts@plt>
    168d:	e8 c8 0a 00 00       	call   215a <read_line>
    1692:	89 04 24             	mov    %eax,(%esp)
    1695:	e8 73 04 00 00       	call   1b0d <phase_8>
    169a:	e8 e4 0b 00 00       	call   2283 <phase_defused>
    169f:	8d 83 36 d1 ff ff    	lea    -0x2eca(%ebx),%eax
    16a5:	89 04 24             	mov    %eax,(%esp)
    16a8:	e8 23 fc ff ff       	call   12d0 <puts@plt>
    16ad:	e8 a8 0a 00 00       	call   215a <read_line>
    16b2:	89 04 24             	mov    %eax,(%esp)
    16b5:	e8 e3 05 00 00       	call   1c9d <phase_9>
    16ba:	e8 c4 0b 00 00       	call   2283 <phase_defused>
    16bf:	8d 83 38 d2 ff ff    	lea    -0x2dc8(%ebx),%eax
    16c5:	89 04 24             	mov    %eax,(%esp)
    16c8:	e8 03 fc ff ff       	call   12d0 <puts@plt>
    16cd:	83 c4 10             	add    $0x10,%esp
    16d0:	b8 00 00 00 00       	mov    $0x0,%eax
    16d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16d8:	59                   	pop    %ecx
    16d9:	5b                   	pop    %ebx
    16da:	5e                   	pop    %esi
    16db:	5d                   	pop    %ebp
    16dc:	8d 61 fc             	lea    -0x4(%ecx),%esp
    16df:	c3                   	ret    
    16e0:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
    16e6:	8b 10                	mov    (%eax),%edx
    16e8:	8d 83 f0 07 00 00    	lea    0x7f0(%ebx),%eax
    16ee:	89 10                	mov    %edx,(%eax)
    16f0:	e9 96 fe ff ff       	jmp    158b <main+0x5e>
    16f5:	ff 76 04             	pushl  0x4(%esi)
    16f8:	ff 36                	pushl  (%esi)
    16fa:	8d 83 b2 d0 ff ff    	lea    -0x2f4e(%ebx),%eax
    1700:	50                   	push   %eax
    1701:	6a 01                	push   $0x1
    1703:	e8 58 fc ff ff       	call   1360 <__printf_chk@plt>
    1708:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    170f:	e8 dc fb ff ff       	call   12f0 <exit@plt>
    1714:	83 ec 04             	sub    $0x4,%esp
    1717:	ff 36                	pushl  (%esi)
    1719:	8d 83 cf d0 ff ff    	lea    -0x2f31(%ebx),%eax
    171f:	50                   	push   %eax
    1720:	6a 01                	push   $0x1
    1722:	e8 39 fc ff ff       	call   1360 <__printf_chk@plt>
    1727:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    172e:	e8 bd fb ff ff       	call   12f0 <exit@plt>

00001733 <phase_1>:     # address 0x56556733
    1733:	f3 0f 1e fb          	endbr32 
    1737:	53                   	push   %ebx
    1738:	83 ec 1c             	sub    $0x1c,%esp
    173b:	e8 f0 fc ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1740:	81 c3 18 48 00 00    	add    $0x4818,%ebx
    1746:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    174c:	89 44 24 10          	mov    %eax,0x10(%esp)
    1750:	31 c0                	xor    %eax,%eax
    1752:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1759:	00 
    175a:	8d 44 24 0c          	lea    0xc(%esp),%eax
    175e:	50                   	push   %eax
    175f:	8d 83 e8 d4 ff ff    	lea    -0x2b18(%ebx),%eax
    1765:	50                   	push   %eax
    1766:	ff 74 24 2c          	pushl  0x2c(%esp)
    176a:	e8 c1 fb ff ff       	call   1330 <__isoc99_sscanf@plt>
    176f:	83 c4 10             	add    $0x10,%esp
    1772:	83 f8 01             	cmp    $0x1,%eax                        # input length = 1
    1775:	75 1c                	jne    1793 <phase_1+0x60>
    1777:	81 7c 24 08 9c 00 00 	cmpl   $0x9c,0x8(%esp)                  # *(esp+8) = 0x9c
    177e:	00 
    177f:	75 19                	jne    179a <phase_1+0x67>
    1781:	8b 44 24 0c          	mov    0xc(%esp),%eax
    1785:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
    178c:	75 13                	jne    17a1 <phase_1+0x6e>
    178e:	83 c4 18             	add    $0x18,%esp
    1791:	5b                   	pop    %ebx
    1792:	c3                   	ret    
    1793:	e8 21 09 00 00       	call   20b9 <explode_bomb>
    1798:	eb dd                	jmp    1777 <phase_1+0x44>
    179a:	e8 1a 09 00 00       	call   20b9 <explode_bomb>
    179f:	eb e0                	jmp    1781 <phase_1+0x4e>
    17a1:	e8 9a 17 00 00       	call   2f40 <__stack_chk_fail_local>

000017a6 <phase_2>: // address 0x565567a6
    17a6:	f3 0f 1e fb          	endbr32 
    17aa:	53                   	push   %ebx
    17ab:	83 ec 10             	sub    $0x10,%esp
    17ae:	e8 7d fc ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    17b3:	81 c3 a5 47 00 00    	add    $0x47a5,%ebx
    17b9:	8d 83 60 d2 ff ff    	lea    -0x2da0(%ebx),%eax
    17bf:	50                   	push   %eax
    17c0:	ff 74 24 1c          	pushl  0x1c(%esp)
    17c4:	e8 f5 05 00 00       	call   1dbe <strings_not_equal>
    17c9:	83 c4 10             	add    $0x10,%esp
    17cc:	85 c0                	test   %eax,%eax                # want eax == 0
    17ce:	75 05                	jne    17d5 <phase_2+0x2f>
    17d0:	83 c4 08             	add    $0x8,%esp
    17d3:	5b                   	pop    %ebx
    17d4:	c3                   	ret    
    17d5:	e8 df 08 00 00       	call   20b9 <explode_bomb>
    17da:	eb f4                	jmp    17d0 <phase_2+0x2a>

000017dc <phase_3>: # address 0x565567dc
    17dc:	f3 0f 1e fb          	endbr32 
    17e0:	53                   	push   %ebx
    17e1:	83 ec 14             	sub    $0x14,%esp
    17e4:	e8 47 fc ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    17e9:	81 c3 6f 47 00 00    	add    $0x476f,%ebx
    17ef:	8d 83 94 d2 ff ff    	lea    -0x2d6c(%ebx),%eax
    17f5:	50                   	push   %eax
    17f6:	e8 a1 05 00 00       	call   1d9c <string_length>
    17fb:	83 c0 01             	add    $0x1,%eax
    17fe:	89 04 24             	mov    %eax,(%esp)
    1801:	e8 ba fa ff ff       	call   12c0 <malloc@plt>
    1806:	c7 00 49 20 61 6d    	movl   $0x6d612049,(%eax)
    180c:	c7 40 04 20 66 6f 72 	movl   $0x726f6620,0x4(%eax)
    1813:	c7 40 08 20 6d 65 64 	movl   $0x64656d20,0x8(%eax)
    181a:	c7 40 0c 69 63 61 6c 	movl   $0x6c616369,0xc(%eax)
    1821:	c7 40 10 20 6c 69 61 	movl   $0x61696c20,0x10(%eax)
    1828:	c7 40 14 62 69 6c 69 	movl   $0x696c6962,0x14(%eax)
    182f:	c7 40 18 74 79 20 61 	movl   $0x61207974,0x18(%eax)
    1836:	c7 40 1c 74 20 74 68 	movl   $0x68742074,0x1c(%eax)
    183d:	c7 40 20 65 20 66 65 	movl   $0x65662065,0x20(%eax)
    1844:	c7 40 24 64 65 72 61 	movl   $0x61726564,0x24(%eax)
    184b:	c7 40 28 6c 20 6c 65 	movl   $0x656c206c,0x28(%eax)
    1852:	c7 40 2c 76 65 6c 2e 	movl   $0x2e6c6576,0x2c(%eax)
    1859:	c6 40 30 00          	movb   $0x0,0x30(%eax)
    185d:	c6 40 2f 61          	movb   $0x61,0x2f(%eax)
    1861:	83 c4 08             	add    $0x8,%esp                # breakpoint here, print string at Mem[eax]
    1864:	50                   	push   %eax
    1865:	ff 74 24 1c          	pushl  0x1c(%esp)
    1869:	e8 50 05 00 00       	call   1dbe <strings_not_equal>
    186e:	83 c4 10             	add    $0x10,%esp
    1871:	85 c0                	test   %eax,%eax
    1873:	75 05                	jne    187a <phase_3+0x9e>
    1875:	83 c4 08             	add    $0x8,%esp
    1878:	5b                   	pop    %ebx
    1879:	c3                   	ret    
    187a:	e8 3a 08 00 00       	call   20b9 <explode_bomb>
    187f:	eb f4                	jmp    1875 <phase_3+0x99>

00001881 <phase_4>: # address 0x56556881
    1881:	f3 0f 1e fb          	endbr32 
    1885:	57                   	push   %edi
    1886:	56                   	push   %esi
    1887:	53                   	push   %ebx
    1888:	83 ec 28             	sub    $0x28,%esp
    188b:	e8 a0 fb ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1890:	81 c3 c8 46 00 00    	add    $0x46c8,%ebx
    1896:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    189c:	89 44 24 24          	mov    %eax,0x24(%esp)
    18a0:	31 c0                	xor    %eax,%eax
    18a2:	8d 44 24 0c          	lea    0xc(%esp),%eax
    18a6:	50                   	push   %eax
    18a7:	ff 74 24 3c          	pushl  0x3c(%esp)
    18ab:	e8 5c 08 00 00       	call   210c <read_six_numbers>      # inpupt is 6 numbers
    18b0:	83 c4 10             	add    $0x10,%esp
    18b3:	83 7c 24 04 05       	cmpl   $0x5,0x4(%esp)               # Mem[esp+4] = 5
    18b8:	75 07                	jne    18c1 <phase_4+0x40>
    18ba:	83 7c 24 08 08       	cmpl   $0x8,0x8(%esp)               # Mem[esp+8] = 8
    18bf:	74 05                	je     18c6 <phase_4+0x45>
    18c1:	e8 f3 07 00 00       	call   20b9 <explode_bomb>
    18c6:	8d 74 24 04          	lea    0x4(%esp),%esi               # esi = esp+4
    18ca:	8d 7c 24 14          	lea    0x14(%esp),%edi              # edi = esp+20
    18ce:	eb 0c                	jmp    18dc <phase_4+0x5b>
    18d0:	e8 e4 07 00 00       	call   20b9 <explode_bomb>
.Loop:
    18d5:	83 c6 04             	add    $0x4,%esi                    # esi += 4 (increment for loop)
    18d8:	39 fe                	cmp    %edi,%esi                    # end loop when esi reaches edi
    18da:	74 0c                	je     18e8 <phase_4+0x67>          # JUMP: end of loop
    18dc:	8b 46 04             	mov    0x4(%esi),%eax               # eax = Mem[esi+4]
    18df:	03 06                	add    (%esi),%eax                  # eax += Mem[esi]
    18e1:	39 46 08             	cmp    %eax,0x8(%esi)               # check: eax == Mem[esi+8] (we want them to equal)
                                                                        # here eax is Mem[esi+4]+Mem[esi]
                                                                        # and we want it equal to Mem[esi+8].
                                                    # So each element of the list is sum of previous 2 numbers.
    18e4:	74 ef                	je     18d5 <phase_4+0x54>
    18e6:	eb e8                	jmp    18d0 <phase_4+0x4f>          # BOMB EXPLODE
    18e8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    18ec:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
    18f3:	75 07                	jne    18fc <phase_4+0x7b>
    18f5:	83 c4 20             	add    $0x20,%esp
    18f8:	5b                   	pop    %ebx
    18f9:	5e                   	pop    %esi
    18fa:	5f                   	pop    %edi
    18fb:	c3                   	ret    
    18fc:	e8 3f 16 00 00       	call   2f40 <__stack_chk_fail_local>

00001901 <phase_5>: # address 0x56556901
    1901:	f3 0f 1e fb          	endbr32 
    1905:	53                   	push   %ebx
    1906:	83 ec 18             	sub    $0x18,%esp
    1909:	e8 22 fb ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    190e:	81 c3 4a 46 00 00    	add    $0x464a,%ebx
    1914:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    191a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    191e:	31 c0                	xor    %eax,%eax
    1920:	8d 44 24 08          	lea    0x8(%esp),%eax
    1924:	50                   	push   %eax
    1925:	8d 44 24 08          	lea    0x8(%esp),%eax
    1929:	50                   	push   %eax
    192a:	8d 83 e5 d4 ff ff    	lea    -0x2b1b(%ebx),%eax
    1930:	50                   	push   %eax
    1931:	ff 74 24 2c          	pushl  0x2c(%esp)
    1935:	e8 f6 f9 ff ff       	call   1330 <__isoc99_sscanf@plt>
    193a:	83 c4 10             	add    $0x10,%esp
    193d:	83 f8 01             	cmp    $0x1,%eax                    # input length > 1
    1940:	7e 17                	jle    1959 <phase_5+0x58>
    1942:	83 7c 24 04 07       	cmpl   $0x7,0x4(%esp)
    1947:	77 5e                	ja     19a7 <.L31+0x7>              # jmp if Mem[esp+4] > 7
                                                                        # THIS IS BOMB EXPLOSION!
                                                                # we want Mem[esp+4] <= 7!
    1949:	8b 44 24 04          	mov    0x4(%esp),%eax               # eax = Mem[esp+4]
    194d:	89 da                	mov    %ebx,%edx                    # edx = ebx
                                                    # gdb: ebx is 0x5655af58 here
                                                    # so edx = 0x5655af58
    194f:	03 94 83 c8 d2 ff ff 	add    -0x2d38(%ebx,%eax,4),%edx    # edx += ebx + 4*eax - 0x2d38
                                                    # edx += Mem(ebx + 4*Mem[esp+4] - 0x2d38)
                                                    # edx = 0x5655af58 + Mem(0x5655af58 + 4*Mem[esp+4] - 0x2d38)
    1956:	3e ff e2             	notrack jmp *%edx                   # jump to address stored at edx
    1959:	e8 5b 07 00 00       	call   20b9 <explode_bomb>
    195e:	eb e2                	jmp    1942 <phase_5+0x41>

    # basically, edx will get calculated (based on first input) to some address in the sections below.
    # the section will then determine what the second input needs to be.

00001960 <.L38>:
    1960:	b8 f1 02 00 00       	mov    $0x2f1,%eax
    1965:	39 44 24 08          	cmp    %eax,0x8(%esp)           # eax is 0x7e now
    1969:	75 4f                	jne    19ba <.L42+0x7>
    196b:	8b 44 24 0c          	mov    0xc(%esp),%eax
    196f:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
    1976:	75 49                	jne    19c1 <.L42+0xe>
    1978:	83 c4 18             	add    $0x18,%esp
    197b:	5b                   	pop    %ebx
    197c:	c3                   	ret    

0000197d <.L37>:
    197d:	b8 be 03 00 00       	mov    $0x3be,%eax
    1982:	eb e1                	jmp    1965 <.L38+0x5>

00001984 <.L36>:
    1984:	b8 ec 02 00 00       	mov    $0x2ec,%eax
    1989:	eb da                	jmp    1965 <.L38+0x5>

0000198b <.L35>:
    198b:	b8 ea 02 00 00       	mov    $0x2ea,%eax
    1990:	eb d3                	jmp    1965 <.L38+0x5>

00001992 <.L34>:
    1992:	b8 ad 02 00 00       	mov    $0x2ad,%eax
    1997:	eb cc                	jmp    1965 <.L38+0x5>

00001999 <.L33>:
    1999:	b8 72 02 00 00       	mov    $0x272,%eax
    199e:	eb c5                	jmp    1965 <.L38+0x5>

000019a0 <.L31>:
    19a0:	b8 7e 00 00 00       	mov    $0x7e,%eax
    19a5:	eb be                	jmp    1965 <.L38+0x5>
    19a7:	e8 0d 07 00 00       	call   20b9 <explode_bomb>
    19ac:	b8 00 00 00 00       	mov    $0x0,%eax
    19b1:	eb b2                	jmp    1965 <.L38+0x5>

000019b3 <.L42>:
    19b3:	b8 bd 02 00 00       	mov    $0x2bd,%eax
    19b8:	eb ab                	jmp    1965 <.L38+0x5>
    19ba:	e8 fa 06 00 00       	call   20b9 <explode_bomb>
    19bf:	eb aa                	jmp    196b <.L38+0xb>
    19c1:	e8 7a 15 00 00       	call   2f40 <__stack_chk_fail_local>

# So the below function takes average of arg1 and arg2, and compare to input1.
# If the average < input, go to L2
# If the avergae > input, go to L1

# The initial arguments are arg1 = 14 and arg2 = 0

000019c6 <func6>:           # initial args: 0xE, 0x0, input_1; want return value = 6
    19c6:	f3 0f 1e fb          	endbr32 
    19ca:	56                   	push   %esi
    19cb:	53                   	push   %ebx
    19cc:	83 ec 04             	sub    $0x4,%esp
# taking the 3 args and putting them in registers
    19cf:	8b 4c 24 10          	mov    0x10(%esp),%ecx          # ecx = Mem[esp+16]
                                            # ecx = arg3: input_1
    19d3:	8b 44 24 14          	mov    0x14(%esp),%eax          # eax = Mem[esp+20]
                                            # eax = arg2: 0
    19d7:	8b 5c 24 18          	mov    0x18(%esp),%ebx          # ebx = Mem[esp+24]
                                            # ebx = arg1: 0xE

# taking the average of arg1 and arg2 ?
    19db:	89 de                	mov    %ebx,%esi                # esi = ebx = Mem[esp+24]
                                                # esi = arg1
    19dd:	29 c6                	sub    %eax,%esi                # esi = Mem[esp+24] - Mem[esp+20]
                                                # esi = arg1 - arg2
    19df:	89 f2                	mov    %esi,%edx                # edx = esi = Mem[esp+24] - Mem[esp+20]
                                                # edx = arg1 - arg2
    19e1:	c1 ea 1f             	shr    $0x1f,%edx               # edx >> 31 (fill with 0)
                                                # edx = sign of edx
    19e4:	01 f2                	add    %esi,%edx                # edx += Mem[esp+24] - Mem[esp+20]
                                                # edx += arg1 - arg2
    19e6:	d1 fa                	sar    %edx                     # edx >> 1 (retain sign)
                                                # edx /= 2
    19e8:	01 c2                	add    %eax,%edx                # edx += Mem[esp+20]
                                                # edx += arg2
# so at this point edx = (arg1 + arg2) / 2?

# comparing the above calculated average with input1
    19ea:	39 ca                	cmp    %ecx,%edx            
    19ec:	7f 0d                	jg     19fb <func6+0x35>    # JMP to L1 if edx > ecx (input_1)
    19ee:	b8 00 00 00 00       	mov    $0x0,%eax            # eax = 0
    19f3:	7c 1b                	jl     1a10 <func6+0x4a>    # JMP to L2, if ecx < edx
# return:
    19f5:	83 c4 04             	add    $0x4,%esp            
    19f8:	5b                   	pop    %ebx
    19f9:	5e                   	pop    %esi
    19fa:	c3                   	ret                     # RETURN
# both L1 and L2 make a recursive call to func6 before returning
# L1 (want to get here once)
    19fb:	83 ec 04             	sub    $0x4,%esp
    19fe:	83 ea 01             	sub    $0x1,%edx            # edx--
    1a01:	52                   	push   %edx                 # arg edx
    1a02:	50                   	push   %eax                 # arg eax
    1a03:	51                   	push   %ecx                 # remains input_1
    1a04:	e8 bd ff ff ff       	call   19c6 <func6>
    1a09:	83 c4 10             	add    $0x10,%esp
    1a0c:	01 c0                	add    %eax,%eax            # !! INCREMENT eax
    1a0e:	eb e5                	jmp    19f5 <func6+0x2f>        # go to return
# L2 (want to get here twice)
    1a10:	83 ec 04             	sub    $0x4,%esp
    1a13:	53                   	push   %ebx
    1a14:	83 c2 01             	add    $0x1,%edx
    1a17:	52                   	push   %edx
    1a18:	51                   	push   %ecx
    1a19:	e8 a8 ff ff ff       	call   19c6 <func6>
    1a1e:	83 c4 10             	add    $0x10,%esp
    1a21:	8d 44 00 01          	lea    0x1(%eax,%eax,1),%eax    # !! INCREMENT eax
            # 1st time we reach here: eax = 0; so after this instruction eax = 1
            # 2nd time we reach here: eax = 1; so after this instruction eax = 3
        # so we want to get this instruction twice, and then get instruction 0x1a0c once to double eax?
    1a25:	eb ce                	jmp    19f5 <func6+0x2f>        # go to return

00001a27 <phase_6>:     # address 0x56556a27
    1a27:	f3 0f 1e fb          	endbr32 
    1a2b:	53                   	push   %ebx
    1a2c:	83 ec 18             	sub    $0x18,%esp
    1a2f:	e8 fc f9 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1a34:	81 c3 24 45 00 00    	add    $0x4524,%ebx
    1a3a:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    1a40:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1a44:	31 c0                	xor    %eax,%eax
    1a46:	8d 44 24 08          	lea    0x8(%esp),%eax
    1a4a:	50                   	push   %eax
    1a4b:	8d 44 24 08          	lea    0x8(%esp),%eax
    1a4f:	50                   	push   %eax
    1a50:	8d 83 e5 d4 ff ff    	lea    -0x2b1b(%ebx),%eax
    1a56:	50                   	push   %eax
    1a57:	ff 74 24 2c          	pushl  0x2c(%esp)
    1a5b:	e8 d0 f8 ff ff       	call   1330 <__isoc99_sscanf@plt>
    1a60:	83 c4 10             	add    $0x10,%esp
    1a63:	83 f8 02             	cmp    $0x2,%eax                    # input length = 2
    1a66:	75 07                	jne    1a6f <phase_6+0x48>
    1a68:	83 7c 24 04 0e       	cmpl   $0xe,0x4(%esp)               
    1a6d:	76 05                	jbe    1a74 <phase_6+0x4d>          # want Mem[esp+4] <= 0xe
    1a6f:	e8 45 06 00 00       	call   20b9 <explode_bomb>
    1a74:	83 ec 04             	sub    $0x4,%esp

# setting up for func6, with arguments 0 and 0xE
    1a77:	6a 0e                	push   $0xe                     # push 0xe onto stack
    1a79:	6a 00                	push   $0x0                     # push 0 onto stack
    1a7b:	ff 74 24 10          	pushl  0x10(%esp)               # push Mem[esp+16] onto stack
    1a7f:	e8 42 ff ff ff       	call   19c6 <func6>
    1a84:	83 c4 10             	add    $0x10,%esp
    1a87:	83 f8 06             	cmp    $0x6,%eax                # need eax == 6
                                                                    # so need func6 to return 6
    1a8a:	75 07                	jne    1a93 <phase_6+0x6c>
    1a8c:	83 7c 24 08 06       	cmpl   $0x6,0x8(%esp)           # need Mem[esp+8] == 6
    1a91:	74 05                	je     1a98 <phase_6+0x71>
    1a93:	e8 21 06 00 00       	call   20b9 <explode_bomb>
    1a98:	8b 44 24 0c          	mov    0xc(%esp),%eax
    1a9c:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
    1aa3:	75 05                	jne    1aaa <phase_6+0x83>
    1aa5:	83 c4 18             	add    $0x18,%esp
    1aa8:	5b                   	pop    %ebx
    1aa9:	c3                   	ret    
    1aaa:	e8 91 14 00 00       	call   2f40 <__stack_chk_fail_local>

00001aaf <phase_7>:
    1aaf:	f3 0f 1e fb          	endbr32 
    1ab3:	57                   	push   %edi
    1ab4:	56                   	push   %esi
    1ab5:	53                   	push   %ebx
    1ab6:	e8 75 f9 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1abb:	81 c3 9d 44 00 00    	add    $0x449d,%ebx
    1ac1:	8b 74 24 10          	mov    0x10(%esp),%esi          # esi = Mem[esp+16]
                                                                    # esi = 0x5655b940?
    1ac5:	83 ec 0c             	sub    $0xc,%esp
    1ac8:	56                   	push   %esi
    1ac9:	e8 ce 02 00 00       	call   1d9c <string_length>
    1ace:	83 c4 10             	add    $0x10,%esp
    1ad1:	83 f8 06             	cmp    $0x6,%eax                # input length is 6
    1ad4:	75 29                	jne    1aff <phase_7+0x50>
    1ad6:	89 f0                	mov    %esi,%eax                # eax = esi = 0x5655b940?
    1ad8:	83 c6 06             	add    $0x6,%esi                # esi += 6 = 0x56556946
    1adb:	b9 00 00 00 00       	mov    $0x0,%ecx                # ecx = 0
    1ae0:	8d bb e8 d2 ff ff    	lea    -0x2d18(%ebx),%edi       # edi = ebx - 0x2d18 = 0x56558240?
# loop:
    # eax starts at 0x56556940, increments by 1 each round, ends when it reaches 0x56556946
    # basically looping through each char of input:
    # 1) index = char % 8 (lower 4 bits of char)
    # 2) ecx += Mem[edi + index * 4] = Mem[0x56558240 + index * 4]
    #           So there's an array of ints starting at 0x56558240?
    #           0x565568240 = 2  <- P (0x50)
    #           0x565568244 = 10 <- Q (0x51)
    #           0x565568248 = 6
    #           0x56556824c = 1
    #           0x565568250 = 12 <- T (0x54)
    #           0x565568254 = 16 <- U (0x55)
    #           0x565568258 = 9  <- V (0x56)
    #           0x56556825C = 3  <- W (0x57)
    #           0x565568260 = 4
    1ae6:	0f b6 10             	movzbl (%eax),%edx              # edx = Mem[eax]
    1ae9:	83 e2 0f             	and    $0xf,%edx                # take lower 4 bits of edx
    1aec:	03 0c 97             	add    (%edi,%edx,4),%ecx       # ecx += Mem[edx*4 + edi]
    1aef:	83 c0 01             	add    $0x1,%eax                # eax++
    1af2:	39 f0                	cmp    %esi,%eax
                                                            # eax = 0x56556940
    1af4:	75 f0                	jne    1ae6 <phase_7+0x37>      # loop if esi != eax

    1af6:	83 f9 34             	cmp    $0x34,%ecx               # after loop, ecx must = 0x34 = 52
    1af9:	75 0b                	jne    1b06 <phase_7+0x57>      # bomb!
    1afb:	5b                   	pop    %ebx
    1afc:	5e                   	pop    %esi
    1afd:	5f                   	pop    %edi
    1afe:	c3                   	ret    
    1aff:	e8 b5 05 00 00       	call   20b9 <explode_bomb>
    1b04:	eb d0                	jmp    1ad6 <phase_7+0x27>
    1b06:	e8 ae 05 00 00       	call   20b9 <explode_bomb>
    1b0b:	eb ee                	jmp    1afb <phase_7+0x4c>

00001b0d <phase_8>: # addr 0x56556b0d
    1b0d:	f3 0f 1e fb          	endbr32 
    1b11:	55                   	push   %ebp
    1b12:	57                   	push   %edi
    1b13:	56                   	push   %esi
    1b14:	53                   	push   %ebx
    1b15:	83 ec 64             	sub    $0x64,%esp
    1b18:	e8 13 f9 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1b1d:	81 c3 3b 44 00 00    	add    $0x443b,%ebx
    1b23:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    1b29:	89 44 24 54          	mov    %eax,0x54(%esp)
    1b2d:	31 c0                	xor    %eax,%eax
    1b2f:	8d 44 24 24          	lea    0x24(%esp),%eax
    1b33:	50                   	push   %eax
    1b34:	ff 74 24 7c          	pushl  0x7c(%esp)
    1b38:	e8 cf 05 00 00       	call   210c <read_six_numbers>      # six numbers
                            # stored from 0xffffc720 to 0xffffc734
    1b3d:	8d 6c 24 30          	lea    0x30(%esp),%ebp              # ebp = esp+0x30 = 0xffffc720
    1b41:	83 c4 10             	add    $0x10,%esp
    1b44:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)               # Mem[esp+12] = 0
                                                                # Mem[esp+12] will serve as some loop index
    1b4b:	00 
    1b4c:	8d 44 24 34          	lea    0x34(%esp),%eax              # eax = esp+0x34
                                                                # Mem[eax] = 80
                                                                # eax = 0xffffc734 => points to 80
    1b50:	89 44 24 08          	mov    %eax,0x8(%esp)               # Mem[esp+8] = eax
                                                                # Mem[esp+8] = eax = 0xffffc734
    1b54:	eb 21                	jmp    1b77 <phase_8+0x6a>          # jmp L1
    1b56:	e8 5e 05 00 00       	call   20b9 <explode_bomb>
    1b5b:	eb 27                	jmp    1b84 <phase_8+0x77>
    1b5d:	e8 57 05 00 00       	call   20b9 <explode_bomb>

# Loop1 and Loop2 below:
# checking all inputs are unique!!!

# Loop 1 (L4+L3):
# so L4 and L3 form one chunk where we check all inputs after a given input[i] are diff from input[i]
# (where i is the loop index for Loop2)
# and go to L5 when we are done
.L4:    # L4 basically increments esi to point to next input
        # jmps to L5 if reaches end of inputs
    1b62:	83 c6 04             	add    $0x4,%esi                    # esi += 4
                                                        # increment esi to point to next input
    1b65:	39 74 24 08          	cmp    %esi,0x8(%esp)           # Mem[esp+8] = 0xffffc734 right now
                                                        # this is the end of the six inputs
    1b69:	74 09                	je     1b74 <phase_8+0x67>      # jmp L5 if (esi == Mem[esp])
                                                        # jmp L5 if reached end of 6 inputs
.L3:    # L3 basically checks that input[edi-4] != input[esi]
        # esi is the loop index for L4+L3, whereas edi is the loop index of loop2
    1b6b:	8b 06                	mov    (%esi),%eax                  # eax = Mem[esi]
                                                        # eax = next input
                                                        # right now esi = ebp = = edi = address of next input
    1b6d:	39 47 fc             	cmp    %eax,-0x4(%edi)              # want: eax != Mem[edi-4]
                                                        # so edi-4 is address of previous input
                                                        # want: input[i] != input[i-1]
    1b70:	75 f0                	jne    1b62 <phase_8+0x55>          # jmp L4
    1b72:	eb e9                	jmp    1b5d <phase_8+0x50>          # BOMB!

# Loop1 seems to be inner loop to Loop2?

# Loop2:
.L5:
    1b74:	83 c5 04             	add    $0x4,%ebp                    # increment ebp to point to next input
.L1:
    1b77:	89 ef                	mov    %ebp,%edi                    # edi = ebp = addr of next input
    1b79:	8b 45 fc             	mov    -0x4(%ebp),%eax              # eax = Mem[ebp-4] = prev input
    1b7c:	83 e8 01             	sub    $0x1,%eax                    # eax-- = prevInput-1
    1b7f:	83 f8 05             	cmp    $0x5,%eax                    # want: eax <= 5
                                                    # so we want every input to be <= 6
    1b82:	77 d2                	ja     1b56 <phase_8+0x49>          # BOMB!
    1b84:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)               # Mem[esp+12]++
                                                    # incrementing loop index = Mem[esp+12]
    1b89:	8b 44 24 0c          	mov    0xc(%esp),%eax               # eax = Mem[esp+12] = updated loop index
    1b8d:	83 f8 05             	cmp    $0x5,%eax                    
    1b90:	7f 04                	jg     1b96 <phase_8+0x89>          # if(eax > 5) jmp L2
                                                    # if incremented loop index > 5, end this loop, jmp L2
                                                    # so this loop repeats 5 times
    1b92:	89 ee                	mov    %ebp,%esi                    # esi = ebp = addr of next input
                                                        # setting esi to address of next input
    1b94:	eb d5                	jmp    1b6b <phase_8+0x5e>          # jmp L3
    
# end of Loop2


.L2:
    1b96:	8d 44 24 1c          	lea    0x1c(%esp),%eax          # eax = 0xffffc72c => points input1
    1b9a:	8d 74 24 34          	lea    0x34(%esp),%esi          # esi = 0xffffc744 => end of inputs
    1b9e:	b9 07 00 00 00       	mov    $0x7,%ecx                # ecx = 7

# loop:
    1ba3:	89 ca                	mov    %ecx,%edx                # edx = ecx = 7
    1ba5:	2b 10                	sub    (%eax),%edx              # edx -= Mem[eax] (input[i])
    1ba7:	89 10                	mov    %edx,(%eax)              # Mem[eax] = input[i] = edx
    1ba9:	83 c0 04             	add    $0x4,%eax                # increment eax to next input
    1bac:	39 c6                	cmp    %eax,%esi
    1bae:	75 f3                	jne    1ba3 <phase_8+0x96>      # esi != eax, continue loop
                # this above loop changes each input[i] to 7-input[i]


    1bb0:	be 00 00 00 00       	mov    $0x0,%esi                # esi = 0 (initialize loop index for below)

# loop 3: (loop 4 is an inner loop)
    1bb5:	89 f7                	mov    %esi,%edi                # edi = esi (loop index)
    1bb7:	8b 4c b4 1c          	mov    0x1c(%esp,%esi,4),%ecx   # ecx = Mem[esp+4*esi+0x1c] (each input[i])
    1bbb:	b8 01 00 00 00       	mov    $0x1,%eax                # eax = 1
    1bc0:	8d 93 a0 05 00 00    	lea    0x5a0(%ebx),%edx         # edx = ebx+0x5a0 = 0x5655b4f8
    1bc6:	83 f9 01             	cmp    $0x1,%ecx                
    1bc9:	7e 0a                	jle    1bd5 <phase_8+0xc8>      # if ecx (input[i]) <= 1: skip the below loop

# loop 4: (this is inner loop to loop 3)
# this loop starts with edx = 0x5655b4f8; for each iteration, edx = Mem[edx+8]
# there are input[i]-1 iterations for each input[i]
#    0 iterations:  edx = 0x5655b4f8                             => points to 0x0d4
#    1 iterations:  edx = Mem[0x5655b4f8+8] = 0x5655b504         => points to 0x079
#    2 iterations:  edx = Mem[0x5655b504+8] = 0x5655b510         => points to 0x2a3
#    3 iterations:  edx = Mem[0x5655b510+8] = 0x5655b51c         => points to 0x2d7
#    4 iterations:  edx = Mem[0x5655b51c+8] = 0x5655b528         => points to 0x18c
#    5 iterations:  edx = Mem[0x5655b528+8] = 0x5655b080         => points to 0x15f
    1bcb:	8b 52 08             	mov    0x8(%edx),%edx           # edx = Mem[edx+8] = 0x5655b504
    1bce:	83 c0 01             	add    $0x1,%eax                # eax++
    1bd1:	39 c8                	cmp    %ecx,%eax                
    1bd3:	75 f6                	jne    1bcb <phase_8+0xbe>      # if ecx (input[i]) != eax, continue loop

            # below: put these new edx values to memory, starting from Mem[esp+0x34]
            # let this be arr[0] to arr[5]
            # e.g.) arr = [0x5655b080, 0x5655b528, 0x5655b51c, 0x5655b510, 0x5655b504, 0x5655b4f8]
    1bd5:	89 54 bc 34          	mov    %edx,0x34(%esp,%edi,4)   # Mem[esp+edi*4+0x34] = edx
    1bd9:	83 c6 01             	add    $0x1,%esi
    1bdc:	83 fe 06             	cmp    $0x6,%esi
    1bdf:	75 d4                	jne    1bb5 <phase_8+0xa8>      # continue with loop3
# end of loop3

# based on Loop4 below, we want Mem[arr[i]] >= Mem[arr[i+1]]
# so arr = [0x5655b51c, 0x5655b510, 0x5655b528, 0x5655b080, 0x5655b4f8, 0x5655b504]
# corresponding to inputs = [4, 3, 5, 6, 1, 2]
# But remember we had the operation where all input[i] became 7-input[i]
# so this gives inputs = [3,4,2,1,6,5]!

# below part:
# for each arr[i], set Mem[arr[i]+8] to arr[i+1]
    1be1:	8b 74 24 34          	mov    0x34(%esp),%esi          # esi = arr[0]
        # esi = 0x5655b080 = arr[0]
    1be5:	8b 44 24 38          	mov    0x38(%esp),%eax          # eax = arr[1]
        # eax = 0x5655b528
    1be9:	89 46 08             	mov    %eax,0x8(%esi)           # Mem[esi+8] = eax = arr[1]
        # Mem[0x5655b088] = 0x5655b528
    1bec:	8b 54 24 3c          	mov    0x3c(%esp),%edx          # edx = Mem[esp+0x3c] = arr[2]
        # edx = 0x5655b51c
    1bf0:	89 50 08             	mov    %edx,0x8(%eax)           # Mem[eax+8] = edx = arr[2]
        # Mem[0x5655b530] = 0x5655b51c
    1bf3:	8b 44 24 40          	mov    0x40(%esp),%eax          # eax = Mem[esp+0x40] = arr[3]
        # eax = 0x5655b510
    1bf7:	89 42 08             	mov    %eax,0x8(%edx)           # Mem[edx+8] = eax = arr[3]
        # Mem[0x5655b524] = 0x5655b510
    1bfa:	8b 54 24 44          	mov    0x44(%esp),%edx          # edx = Mem[esp+0x44] = arr[4]
        # edx = 0x5655b504
    1bfe:	89 50 08             	mov    %edx,0x8(%eax)           # Mem[eax+8] = edx = arr[4]
        # Mem[0x5655b518] = 0x5655b504
    1c01:	8b 44 24 48          	mov    0x48(%esp),%eax          # eax = Mem[esp+0x48] = arr[5]
        # eax = 0x5655b4f8
    1c05:	89 42 08             	mov    %eax,0x8(%edx)           # Mem[edx+8] = eax = arr[5]
        # Mem[0x5655b50c] = 0x5655b4f8
    1c08:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)           # Mem[eax+8] = 0
        # Mem[0x5655b500] = 0
    1c0f:	bf 05 00 00 00       	mov    $0x5,%edi                # edi = 5
    1c14:	eb 08                	jmp    1c1e <phase_8+0x111>

.Loop4: # iterates from edi=5 to edi=0
    1c16:	8b 76 08             	mov    0x8(%esi),%esi               # esi = Mem[esi+8]
                                                            # esi is moving on to next element in arr
                                                            # suppose esi = arr[i]
    1c19:	83 ef 01             	sub    $0x1,%edi                    # edi-- (decrement loop index)
    1c1c:	74 10                	je     1c2e <phase_8+0x121>         # if edi == 0: RET
    1c1e:	8b 46 08             	mov    0x8(%esi),%eax               # eax = Mem[esi+8] = arr[i+1]
    1c21:	8b 00                	mov    (%eax),%eax                  # eax = Mem[eax] = Mem[arr[i+1]]

    1c23:	39 06                	cmp    %eax,(%esi)
    1c25:	7d ef                	jge    1c16 <phase_8+0x109>         # continue loop if Mem[esi] >= eax
                                                            # so we want Mem[arr[i]] >= Mem[arr[i+1]]
                                                                        # else BOMB

    1c27:	e8 8d 04 00 00       	call   20b9 <explode_bomb>          # BOMB  
    1c2c:	eb e8                	jmp    1c16 <phase_8+0x109>
    1c2e:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    1c32:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
    1c39:	75 08                	jne    1c43 <phase_8+0x136>
    1c3b:	83 c4 5c             	add    $0x5c,%esp
    1c3e:	5b                   	pop    %ebx
    1c3f:	5e                   	pop    %esi
    1c40:	5f                   	pop    %edi
    1c41:	5d                   	pop    %ebp
    1c42:	c3                   	ret    
    1c43:	e8 f8 12 00 00       	call   2f40 <__stack_chk_fail_local>

00001c48 <fun9>:        # need to return 6!
    1c48:	f3 0f 1e fb          	endbr32 
    1c4c:	53                   	push   %ebx
    1c4d:	83 ec 08             	sub    $0x8,%esp
    1c50:	8b 54 24 10          	mov    0x10(%esp),%edx          # edx = arg2
                    # edx starts off as ebx+0x54c; and ebx starts off as 0x5655af58
                    # so edx = 0x5655b4a4                           => points to 0x32
                    #       so for the first jmp to recursion1, we need input < 0x32
                    # next edx = Mem[prev_edx + 4] = 0x5655b4b0     => points to 0x9
                    #       so for the second jmp to recursion2, we need input > 9
                    # next edx = Mem[prev_edx + 8] = 0x5655b4c8     => points to 0x1e
                    #       so for the third jmp to recursion2, we need input > 0x1e (30)
                    # next edx = Mem[prev_edx + 8] = 0x5655b044     => points to 0x28
                    #       so for this to go straight to return, we need input == 0x28 == 40
    1c54:	8b 4c 24 14          	mov    0x14(%esp),%ecx          # ecx = arg1 = input
    1c58:	85 d2                	test   %edx,%edx                # want: edx != 0 (checking for nullptr)
    1c5a:	74 3a                	je     1c96 <fun9+0x4e>         # DO NOT WANT THIS! will return with -1
    1c5c:	8b 1a                	mov    (%edx),%ebx              # ebx = Mem[edx]
    1c5e:	39 cb                	cmp    %ecx,%ebx
    1c60:	7f 0c                	jg     1c6e <fun9+0x26>         # jmp recursion1 if ebx > ecx
                    # want this jmp to recursion1 first
                    # so ecx (input) < 0x32
    1c62:	b8 00 00 00 00       	mov    $0x0,%eax                # eax = 0
    1c67:	75 18                	jne    1c81 <fun9+0x39>         # jmp recursion2 if ebx != ecx
                    # in recursion1, want to trigger this jmp twice
                                                                    # if ebx == ecx: will return 0

    1c69:	83 c4 08             	add    $0x8,%esp
    1c6c:	5b                   	pop    %ebx
    1c6d:	c3                   	ret  

# recursion1: (want this once)
    1c6e:	83 ec 08             	sub    $0x8,%esp
    1c71:	51                   	push   %ecx                 # arg1: input
    1c72:	ff 72 04             	pushl  0x4(%edx)            # arg2: Mem[edx+4]
    1c75:	e8 ce ff ff ff       	call   1c48 <fun9>          # recursion

    1c7a:	83 c4 10             	add    $0x10,%esp
    1c7d:	01 c0                	add    %eax,%eax            # eax *= 2
    1c7f:	eb e8                	jmp    1c69 <fun9+0x21>     # RETURN

# recursion2: (want this twice)
    1c81:	83 ec 08             	sub    $0x8,%esp
    1c84:	51                   	push   %ecx                 # arg1: input
    1c85:	ff 72 08             	pushl  0x8(%edx)            # arg2: Mem[edx+8]
    1c88:	e8 bb ff ff ff       	call   1c48 <fun9>          # recursion

    1c8d:	83 c4 10             	add    $0x10,%esp
    1c90:	8d 44 00 01          	lea    0x1(%eax,%eax,1),%eax    # eax = eax + eax + 1
                    # same as func6: want to get eax = eax + eax + 1 twice
                    # and then get eax *= 2 once
                    # in order to get return value of 6
    1c94:	eb d3                	jmp    1c69 <fun9+0x21>             # RETURN
    1c96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax         # only get here if nullptr
    1c9b:	eb cc                	jmp    1c69 <fun9+0x21>             # RETURN

00001c9d <phase_9>:
    1c9d:	f3 0f 1e fb          	endbr32 
    1ca1:	56                   	push   %esi
    1ca2:	53                   	push   %ebx
    1ca3:	83 ec 08             	sub    $0x8,%esp
    1ca6:	e8 85 f7 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1cab:	81 c3 ad 42 00 00    	add    $0x42ad,%ebx
    1cb1:	6a 0a                	push   $0xa
    1cb3:	6a 00                	push   $0x0
    1cb5:	ff 74 24 1c          	pushl  0x1c(%esp)
    1cb9:	e8 e2 f6 ff ff       	call   13a0 <strtol@plt>            # string to long
    1cbe:	89 c6                	mov    %eax,%esi                    # esi = eax
    1cc0:	8d 40 ff             	lea    -0x1(%eax),%eax              # eax--
    1cc3:	83 c4 10             	add    $0x10,%esp
    1cc6:	3d ec 03 00 00       	cmp    $0x3ec,%eax                  # want eax <= 0x3ec
    1ccb:	77 1e                	ja     1ceb <phase_9+0x4e>          # BOMB!
    1ccd:	83 ec 08             	sub    $0x8,%esp
    1cd0:	56                   	push   %esi                         # arg1: esi = (input)
    1cd1:	8d 83 4c 05 00 00    	lea    0x54c(%ebx),%eax
    1cd7:	50                   	push   %eax                         # arg2: eax = ebx+0x54c
    1cd8:	e8 6b ff ff ff       	call   1c48 <fun9>                  # call func; need return 6
    1cdd:	83 c4 10             	add    $0x10,%esp
    1ce0:	83 f8 06             	cmp    $0x6,%eax                    # want: eax == 6
    1ce3:	75 0d                	jne    1cf2 <phase_9+0x55>          # BOMB!
    1ce5:	83 c4 04             	add    $0x4,%esp
    1ce8:	5b                   	pop    %ebx
    1ce9:	5e                   	pop    %esi
    1cea:	c3                   	ret    
    1ceb:	e8 c9 03 00 00       	call   20b9 <explode_bomb>
    1cf0:	eb db                	jmp    1ccd <phase_9+0x30>
    1cf2:	e8 c2 03 00 00       	call   20b9 <explode_bomb>
    1cf7:	eb ec                	jmp    1ce5 <phase_9+0x48>

00001cf9 <sig_handler>:
    1cf9:	f3 0f 1e fb          	endbr32 
    1cfd:	53                   	push   %ebx
    1cfe:	83 ec 14             	sub    $0x14,%esp
    1d01:	e8 2a f7 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1d06:	81 c3 52 42 00 00    	add    $0x4252,%ebx
    1d0c:	8d 83 28 d3 ff ff    	lea    -0x2cd8(%ebx),%eax
    1d12:	50                   	push   %eax
    1d13:	e8 b8 f5 ff ff       	call   12d0 <puts@plt>
    1d18:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    1d1f:	e8 3c f5 ff ff       	call   1260 <sleep@plt>
    1d24:	83 c4 08             	add    $0x8,%esp
    1d27:	8d 83 61 d4 ff ff    	lea    -0x2b9f(%ebx),%eax
    1d2d:	50                   	push   %eax
    1d2e:	6a 01                	push   $0x1
    1d30:	e8 2b f6 ff ff       	call   1360 <__printf_chk@plt>
    1d35:	83 c4 04             	add    $0x4,%esp
    1d38:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
    1d3e:	ff 30                	pushl  (%eax)
    1d40:	e8 eb f4 ff ff       	call   1230 <fflush@plt>
    1d45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d4c:	e8 0f f5 ff ff       	call   1260 <sleep@plt>
    1d51:	8d 83 69 d4 ff ff    	lea    -0x2b97(%ebx),%eax
    1d57:	89 04 24             	mov    %eax,(%esp)
    1d5a:	e8 71 f5 ff ff       	call   12d0 <puts@plt>
    1d5f:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
    1d66:	e8 85 f5 ff ff       	call   12f0 <exit@plt>

00001d6b <invalid_phase>:
    1d6b:	f3 0f 1e fb          	endbr32 
    1d6f:	53                   	push   %ebx
    1d70:	83 ec 0c             	sub    $0xc,%esp
    1d73:	e8 b8 f6 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1d78:	81 c3 e0 41 00 00    	add    $0x41e0,%ebx
    1d7e:	ff 74 24 14          	pushl  0x14(%esp)
    1d82:	8d 83 71 d4 ff ff    	lea    -0x2b8f(%ebx),%eax
    1d88:	50                   	push   %eax
    1d89:	6a 01                	push   $0x1
    1d8b:	e8 d0 f5 ff ff       	call   1360 <__printf_chk@plt>
    1d90:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1d97:	e8 54 f5 ff ff       	call   12f0 <exit@plt>

00001d9c <string_length>:
    1d9c:	f3 0f 1e fb          	endbr32 
    1da0:	8b 54 24 04          	mov    0x4(%esp),%edx
    1da4:	80 3a 00             	cmpb   $0x0,(%edx)
    1da7:	74 0f                	je     1db8 <string_length+0x1c>
    1da9:	b8 00 00 00 00       	mov    $0x0,%eax
    1dae:	83 c0 01             	add    $0x1,%eax
    1db1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1db5:	75 f7                	jne    1dae <string_length+0x12>
    1db7:	c3                   	ret    
    1db8:	b8 00 00 00 00       	mov    $0x0,%eax
    1dbd:	c3                   	ret    

# addr = 0x56556dbe
00001dbe <strings_not_equal>:       # equal: return value eax == 0 (this is what we want!)
    1dbe:	f3 0f 1e fb          	endbr32 
    1dc2:	57                   	push   %edi
    1dc3:	56                   	push   %esi
    1dc4:	53                   	push   %ebx
    1dc5:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    1dc9:	8b 74 24 14          	mov    0x14(%esp),%esi
    1dcd:	53                   	push   %ebx
    1dce:	e8 c9 ff ff ff       	call   1d9c <string_length>
    1dd3:	89 c7                	mov    %eax,%edi
    1dd5:	89 34 24             	mov    %esi,(%esp)
    1dd8:	e8 bf ff ff ff       	call   1d9c <string_length>
    1ddd:	83 c4 04             	add    $0x4,%esp
    1de0:	89 c2                	mov    %eax,%edx
    1de2:	b8 01 00 00 00       	mov    $0x1,%eax            # init eax = 1
    1de7:	39 d7                	cmp    %edx,%edi
    1de9:	75 2b                	jne    1e16 <strings_not_equal+0x58>
    1deb:	0f b6 03             	movzbl (%ebx),%eax
    1dee:	84 c0                	test   %al,%al
    1df0:	74 18                	je     1e0a <strings_not_equal+0x4c>
    1df2:	38 06                	cmp    %al,(%esi)           # Mem[esi] is the target string!
    1df4:	75 1b                	jne    1e11 <strings_not_equal+0x53>
    1df6:	83 c3 01             	add    $0x1,%ebx
    1df9:	83 c6 01             	add    $0x1,%esi
    1dfc:	0f b6 03             	movzbl (%ebx),%eax
    1dff:	84 c0                	test   %al,%al
    1e01:	75 ef                	jne    1df2 <strings_not_equal+0x34>
    1e03:	b8 00 00 00 00       	mov    $0x0,%eax
    1e08:	eb 0c                	jmp    1e16 <strings_not_equal+0x58>
    1e0a:	b8 00 00 00 00       	mov    $0x0,%eax
    1e0f:	eb 05                	jmp    1e16 <strings_not_equal+0x58>
    1e11:	b8 01 00 00 00       	mov    $0x1,%eax
    1e16:	5b                   	pop    %ebx
    1e17:	5e                   	pop    %esi
    1e18:	5f                   	pop    %edi
    1e19:	c3                   	ret    

00001e1a <initialize_bomb>:
    1e1a:	f3 0f 1e fb          	endbr32 
    1e1e:	57                   	push   %edi
    1e1f:	56                   	push   %esi
    1e20:	53                   	push   %ebx
    1e21:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    1e27:	83 0c 24 00          	orl    $0x0,(%esp)
    1e2b:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    1e31:	83 0c 24 00          	orl    $0x0,(%esp)
    1e35:	83 ec 58             	sub    $0x58,%esp
    1e38:	e8 f3 f5 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1e3d:	81 c3 1b 41 00 00    	add    $0x411b,%ebx
    1e43:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    1e49:	89 84 24 54 20 00 00 	mov    %eax,0x2054(%esp)
    1e50:	31 c0                	xor    %eax,%eax
    1e52:	8d 83 a1 bd ff ff    	lea    -0x425f(%ebx),%eax
    1e58:	50                   	push   %eax
    1e59:	6a 02                	push   $0x2
    1e5b:	e8 f0 f3 ff ff       	call   1250 <signal@plt>
    1e60:	83 c4 08             	add    $0x8,%esp
    1e63:	6a 40                	push   $0x40
    1e65:	8d 44 24 18          	lea    0x18(%esp),%eax
    1e69:	50                   	push   %eax
    1e6a:	e8 31 f4 ff ff       	call   12a0 <gethostname@plt>
    1e6f:	83 c4 10             	add    $0x10,%esp
    1e72:	85 c0                	test   %eax,%eax
    1e74:	75 4a                	jne    1ec0 <initialize_bomb+0xa6>
    1e76:	8b 83 e8 05 00 00    	mov    0x5e8(%ebx),%eax
    1e7c:	8d b3 ec 05 00 00    	lea    0x5ec(%ebx),%esi
    1e82:	8d 7c 24 0c          	lea    0xc(%esp),%edi
    1e86:	85 c0                	test   %eax,%eax
    1e88:	74 1b                	je     1ea5 <initialize_bomb+0x8b>
    1e8a:	83 ec 08             	sub    $0x8,%esp
    1e8d:	57                   	push   %edi
    1e8e:	50                   	push   %eax
    1e8f:	e8 8c f4 ff ff       	call   1320 <strcasecmp@plt>
    1e94:	83 c4 10             	add    $0x10,%esp
    1e97:	85 c0                	test   %eax,%eax
    1e99:	74 62                	je     1efd <initialize_bomb+0xe3>
    1e9b:	83 c6 04             	add    $0x4,%esi
    1e9e:	8b 46 fc             	mov    -0x4(%esi),%eax
    1ea1:	85 c0                	test   %eax,%eax
    1ea3:	75 e5                	jne    1e8a <initialize_bomb+0x70>
    1ea5:	83 ec 0c             	sub    $0xc,%esp
    1ea8:	8d 83 98 d3 ff ff    	lea    -0x2c68(%ebx),%eax
    1eae:	50                   	push   %eax
    1eaf:	e8 1c f4 ff ff       	call   12d0 <puts@plt>
    1eb4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1ebb:	e8 30 f4 ff ff       	call   12f0 <exit@plt>
    1ec0:	83 ec 0c             	sub    $0xc,%esp
    1ec3:	8d 83 60 d3 ff ff    	lea    -0x2ca0(%ebx),%eax
    1ec9:	50                   	push   %eax
    1eca:	e8 01 f4 ff ff       	call   12d0 <puts@plt>
    1ecf:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1ed6:	e8 15 f4 ff ff       	call   12f0 <exit@plt>
    1edb:	83 ec 04             	sub    $0x4,%esp
    1ede:	8d 44 24 50          	lea    0x50(%esp),%eax
    1ee2:	50                   	push   %eax
    1ee3:	8d 83 82 d4 ff ff    	lea    -0x2b7e(%ebx),%eax
    1ee9:	50                   	push   %eax
    1eea:	6a 01                	push   $0x1
    1eec:	e8 6f f4 ff ff       	call   1360 <__printf_chk@plt>
    1ef1:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1ef8:	e8 f3 f3 ff ff       	call   12f0 <exit@plt>
    1efd:	83 ec 0c             	sub    $0xc,%esp
    1f00:	8d 44 24 58          	lea    0x58(%esp),%eax
    1f04:	50                   	push   %eax
    1f05:	e8 1d 0d 00 00       	call   2c27 <init_driver>
    1f0a:	83 c4 10             	add    $0x10,%esp
    1f0d:	85 c0                	test   %eax,%eax
    1f0f:	78 ca                	js     1edb <initialize_bomb+0xc1>
    1f11:	8b 84 24 4c 20 00 00 	mov    0x204c(%esp),%eax
    1f18:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
    1f1f:	75 0a                	jne    1f2b <initialize_bomb+0x111>
    1f21:	81 c4 50 20 00 00    	add    $0x2050,%esp
    1f27:	5b                   	pop    %ebx
    1f28:	5e                   	pop    %esi
    1f29:	5f                   	pop    %edi
    1f2a:	c3                   	ret    
    1f2b:	e8 10 10 00 00       	call   2f40 <__stack_chk_fail_local>

00001f30 <initialize_bomb_solve>:
    1f30:	f3 0f 1e fb          	endbr32 
    1f34:	c3                   	ret    

00001f35 <blank_line>:
    1f35:	f3 0f 1e fb          	endbr32 
    1f39:	57                   	push   %edi
    1f3a:	56                   	push   %esi
    1f3b:	53                   	push   %ebx
    1f3c:	e8 ef f4 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1f41:	81 c3 17 40 00 00    	add    $0x4017,%ebx
    1f47:	8b 7c 24 10          	mov    0x10(%esp),%edi
    1f4b:	0f b6 37             	movzbl (%edi),%esi
    1f4e:	89 f0                	mov    %esi,%eax
    1f50:	84 c0                	test   %al,%al
    1f52:	74 1d                	je     1f71 <blank_line+0x3c>
    1f54:	e8 77 f4 ff ff       	call   13d0 <__ctype_b_loc@plt>
    1f59:	83 c7 01             	add    $0x1,%edi
    1f5c:	89 f2                	mov    %esi,%edx
    1f5e:	0f be f2             	movsbl %dl,%esi
    1f61:	8b 00                	mov    (%eax),%eax
    1f63:	f6 44 70 01 20       	testb  $0x20,0x1(%eax,%esi,2)
    1f68:	75 e1                	jne    1f4b <blank_line+0x16>
    1f6a:	b8 00 00 00 00       	mov    $0x0,%eax
    1f6f:	eb 05                	jmp    1f76 <blank_line+0x41>
    1f71:	b8 01 00 00 00       	mov    $0x1,%eax
    1f76:	5b                   	pop    %ebx
    1f77:	5e                   	pop    %esi
    1f78:	5f                   	pop    %edi
    1f79:	c3                   	ret    

00001f7a <skip>:
    1f7a:	f3 0f 1e fb          	endbr32 
    1f7e:	55                   	push   %ebp
    1f7f:	57                   	push   %edi
    1f80:	56                   	push   %esi
    1f81:	53                   	push   %ebx
    1f82:	83 ec 0c             	sub    $0xc,%esp
    1f85:	e8 a6 f4 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1f8a:	81 c3 ce 3f 00 00    	add    $0x3fce,%ebx
    1f90:	8d bb f0 07 00 00    	lea    0x7f0(%ebx),%edi
    1f96:	8d b3 08 08 00 00    	lea    0x808(%ebx),%esi
    1f9c:	83 ec 04             	sub    $0x4,%esp
    1f9f:	ff 37                	pushl  (%edi)
    1fa1:	6a 50                	push   $0x50
    1fa3:	8b 83 ec 07 00 00    	mov    0x7ec(%ebx),%eax
    1fa9:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1fac:	c1 e0 04             	shl    $0x4,%eax
    1faf:	01 f0                	add    %esi,%eax
    1fb1:	50                   	push   %eax
    1fb2:	e8 89 f2 ff ff       	call   1240 <fgets@plt>
    1fb7:	89 c5                	mov    %eax,%ebp
    1fb9:	83 c4 10             	add    $0x10,%esp
    1fbc:	85 c0                	test   %eax,%eax
    1fbe:	74 10                	je     1fd0 <skip+0x56>
    1fc0:	83 ec 0c             	sub    $0xc,%esp
    1fc3:	50                   	push   %eax
    1fc4:	e8 6c ff ff ff       	call   1f35 <blank_line>
    1fc9:	83 c4 10             	add    $0x10,%esp
    1fcc:	85 c0                	test   %eax,%eax
    1fce:	75 cc                	jne    1f9c <skip+0x22>
    1fd0:	89 e8                	mov    %ebp,%eax
    1fd2:	83 c4 0c             	add    $0xc,%esp
    1fd5:	5b                   	pop    %ebx
    1fd6:	5e                   	pop    %esi
    1fd7:	5f                   	pop    %edi
    1fd8:	5d                   	pop    %ebp
    1fd9:	c3                   	ret    

00001fda <send_msg>:
    1fda:	f3 0f 1e fb          	endbr32 
    1fde:	56                   	push   %esi
    1fdf:	53                   	push   %ebx
    1fe0:	8d 84 24 00 c0 ff ff 	lea    -0x4000(%esp),%eax
    1fe7:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    1fed:	83 0c 24 00          	orl    $0x0,(%esp)
    1ff1:	39 c4                	cmp    %eax,%esp
    1ff3:	75 f2                	jne    1fe7 <send_msg+0xd>
    1ff5:	83 ec 14             	sub    $0x14,%esp
    1ff8:	e8 33 f4 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    1ffd:	81 c3 5b 3f 00 00    	add    $0x3f5b,%ebx
    2003:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    2009:	89 84 24 0c 40 00 00 	mov    %eax,0x400c(%esp)
    2010:	31 c0                	xor    %eax,%eax
    2012:	8b 8b ec 07 00 00    	mov    0x7ec(%ebx),%ecx
    2018:	8d 44 89 fb          	lea    -0x5(%ecx,%ecx,4),%eax
    201c:	c1 e0 04             	shl    $0x4,%eax
    201f:	03 83 84 00 00 00    	add    0x84(%ebx),%eax
    2025:	83 bc 24 20 40 00 00 	cmpl   $0x0,0x4020(%esp)
    202c:	00 
    202d:	8d 93 9c d4 ff ff    	lea    -0x2b64(%ebx),%edx
    2033:	8d b3 a4 d4 ff ff    	lea    -0x2b5c(%ebx),%esi
    2039:	0f 44 d6             	cmove  %esi,%edx
    203c:	50                   	push   %eax
    203d:	51                   	push   %ecx
    203e:	52                   	push   %edx
    203f:	8d 83 48 05 00 00    	lea    0x548(%ebx),%eax
    2045:	ff 30                	pushl  (%eax)
    2047:	8d 83 ad d4 ff ff    	lea    -0x2b53(%ebx),%eax
    204d:	50                   	push   %eax
    204e:	68 00 20 00 00       	push   $0x2000
    2053:	6a 01                	push   $0x1
    2055:	8d 74 24 28          	lea    0x28(%esp),%esi
    2059:	56                   	push   %esi
    205a:	e8 81 f3 ff ff       	call   13e0 <__sprintf_chk@plt>
    205f:	83 c4 20             	add    $0x20,%esp
    2062:	8d 84 24 0c 20 00 00 	lea    0x200c(%esp),%eax
    2069:	50                   	push   %eax
    206a:	6a 00                	push   $0x0
    206c:	56                   	push   %esi
    206d:	ff b3 9c 00 00 00    	pushl  0x9c(%ebx)
    2073:	e8 a8 0d 00 00       	call   2e20 <driver_post>
    2078:	83 c4 10             	add    $0x10,%esp
    207b:	85 c0                	test   %eax,%eax
    207d:	78 19                	js     2098 <send_msg+0xbe>
    207f:	8b 84 24 0c 40 00 00 	mov    0x400c(%esp),%eax
    2086:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
    208d:	75 25                	jne    20b4 <send_msg+0xda>
    208f:	81 c4 14 40 00 00    	add    $0x4014,%esp
    2095:	5b                   	pop    %ebx
    2096:	5e                   	pop    %esi
    2097:	c3                   	ret    
    2098:	83 ec 0c             	sub    $0xc,%esp
    209b:	8d 84 24 18 20 00 00 	lea    0x2018(%esp),%eax
    20a2:	50                   	push   %eax
    20a3:	e8 28 f2 ff ff       	call   12d0 <puts@plt>
    20a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    20af:	e8 3c f2 ff ff       	call   12f0 <exit@plt>
    20b4:	e8 87 0e 00 00       	call   2f40 <__stack_chk_fail_local>

000020b9 <explode_bomb>:
    20b9:	f3 0f 1e fb          	endbr32 
    20bd:	53                   	push   %ebx
    20be:	83 ec 14             	sub    $0x14,%esp
    20c1:	e8 6a f3 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    20c6:	81 c3 92 3e 00 00    	add    $0x3e92,%ebx
    20cc:	8d 83 b9 d4 ff ff    	lea    -0x2b47(%ebx),%eax
    20d2:	50                   	push   %eax
    20d3:	e8 f8 f1 ff ff       	call   12d0 <puts@plt>
    20d8:	8d 83 c2 d4 ff ff    	lea    -0x2b3e(%ebx),%eax
    20de:	89 04 24             	mov    %eax,(%esp)
    20e1:	e8 ea f1 ff ff       	call   12d0 <puts@plt>
    20e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    20ed:	e8 e8 fe ff ff       	call   1fda <send_msg>
    20f2:	8d 83 d0 d3 ff ff    	lea    -0x2c30(%ebx),%eax
    20f8:	89 04 24             	mov    %eax,(%esp)
    20fb:	e8 d0 f1 ff ff       	call   12d0 <puts@plt>
    2100:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    2107:	e8 e4 f1 ff ff       	call   12f0 <exit@plt>

0000210c <read_six_numbers>:
    210c:	f3 0f 1e fb          	endbr32 
    2110:	53                   	push   %ebx
    2111:	83 ec 08             	sub    $0x8,%esp
    2114:	e8 17 f3 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2119:	81 c3 3f 3e 00 00    	add    $0x3e3f,%ebx
    211f:	8b 44 24 14          	mov    0x14(%esp),%eax
    2123:	8d 50 14             	lea    0x14(%eax),%edx
    2126:	52                   	push   %edx
    2127:	8d 50 10             	lea    0x10(%eax),%edx
    212a:	52                   	push   %edx
    212b:	8d 50 0c             	lea    0xc(%eax),%edx
    212e:	52                   	push   %edx
    212f:	8d 50 08             	lea    0x8(%eax),%edx
    2132:	52                   	push   %edx
    2133:	8d 50 04             	lea    0x4(%eax),%edx
    2136:	52                   	push   %edx
    2137:	50                   	push   %eax
    2138:	8d 83 d9 d4 ff ff    	lea    -0x2b27(%ebx),%eax
    213e:	50                   	push   %eax
    213f:	ff 74 24 2c          	pushl  0x2c(%esp)
    2143:	e8 e8 f1 ff ff       	call   1330 <__isoc99_sscanf@plt>
    2148:	83 c4 20             	add    $0x20,%esp
    214b:	83 f8 05             	cmp    $0x5,%eax
    214e:	7e 05                	jle    2155 <read_six_numbers+0x49>
    2150:	83 c4 08             	add    $0x8,%esp
    2153:	5b                   	pop    %ebx
    2154:	c3                   	ret    
    2155:	e8 5f ff ff ff       	call   20b9 <explode_bomb>

0000215a <read_line>:
    215a:	f3 0f 1e fb          	endbr32 
    215e:	57                   	push   %edi
    215f:	56                   	push   %esi
    2160:	53                   	push   %ebx
    2161:	e8 ca f2 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2166:	81 c3 f2 3d 00 00    	add    $0x3df2,%ebx
    216c:	e8 09 fe ff ff       	call   1f7a <skip>
    2171:	85 c0                	test   %eax,%eax
    2173:	74 4e                	je     21c3 <read_line+0x69>
    2175:	8b 93 ec 07 00 00    	mov    0x7ec(%ebx),%edx
    217b:	8d 34 92             	lea    (%edx,%edx,4),%esi
    217e:	c1 e6 04             	shl    $0x4,%esi
    2181:	03 b3 84 00 00 00    	add    0x84(%ebx),%esi
    2187:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    218c:	b8 00 00 00 00       	mov    $0x0,%eax
    2191:	89 f7                	mov    %esi,%edi
    2193:	f2 ae                	repnz scas %es:(%edi),%al
    2195:	f7 d1                	not    %ecx
    2197:	83 e9 01             	sub    $0x1,%ecx
    219a:	83 f9 4e             	cmp    $0x4e,%ecx
    219d:	0f 8f a5 00 00 00    	jg     2248 <read_line+0xee>
    21a3:	8d 04 92             	lea    (%edx,%edx,4),%eax
    21a6:	c1 e0 04             	shl    $0x4,%eax
    21a9:	03 83 84 00 00 00    	add    0x84(%ebx),%eax
    21af:	c6 44 01 ff 00       	movb   $0x0,-0x1(%ecx,%eax,1)
    21b4:	83 c2 01             	add    $0x1,%edx
    21b7:	89 93 ec 07 00 00    	mov    %edx,0x7ec(%ebx)
    21bd:	89 f0                	mov    %esi,%eax
    21bf:	5b                   	pop    %ebx
    21c0:	5e                   	pop    %esi
    21c1:	5f                   	pop    %edi
    21c2:	c3                   	ret    
    21c3:	8d 93 f0 07 00 00    	lea    0x7f0(%ebx),%edx
    21c9:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
    21cf:	8b 00                	mov    (%eax),%eax
    21d1:	39 02                	cmp    %eax,(%edx)
    21d3:	74 20                	je     21f5 <read_line+0x9b>
    21d5:	83 ec 0c             	sub    $0xc,%esp
    21d8:	8d 83 09 d5 ff ff    	lea    -0x2af7(%ebx),%eax
    21de:	50                   	push   %eax
    21df:	e8 cc f0 ff ff       	call   12b0 <getenv@plt>
    21e4:	83 c4 10             	add    $0x10,%esp
    21e7:	85 c0                	test   %eax,%eax
    21e9:	74 25                	je     2210 <read_line+0xb6>
    21eb:	83 ec 0c             	sub    $0xc,%esp
    21ee:	6a 00                	push   $0x0
    21f0:	e8 fb f0 ff ff       	call   12f0 <exit@plt>
    21f5:	83 ec 0c             	sub    $0xc,%esp
    21f8:	8d 83 eb d4 ff ff    	lea    -0x2b15(%ebx),%eax
    21fe:	50                   	push   %eax
    21ff:	e8 cc f0 ff ff       	call   12d0 <puts@plt>
    2204:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    220b:	e8 e0 f0 ff ff       	call   12f0 <exit@plt>
    2210:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
    2216:	8b 10                	mov    (%eax),%edx
    2218:	8d 83 f0 07 00 00    	lea    0x7f0(%ebx),%eax
    221e:	89 10                	mov    %edx,(%eax)
    2220:	e8 55 fd ff ff       	call   1f7a <skip>
    2225:	85 c0                	test   %eax,%eax
    2227:	0f 85 48 ff ff ff    	jne    2175 <read_line+0x1b>
    222d:	83 ec 0c             	sub    $0xc,%esp
    2230:	8d 83 eb d4 ff ff    	lea    -0x2b15(%ebx),%eax
    2236:	50                   	push   %eax
    2237:	e8 94 f0 ff ff       	call   12d0 <puts@plt>
    223c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2243:	e8 a8 f0 ff ff       	call   12f0 <exit@plt>
    2248:	83 ec 0c             	sub    $0xc,%esp
    224b:	8d 83 14 d5 ff ff    	lea    -0x2aec(%ebx),%eax
    2251:	50                   	push   %eax
    2252:	e8 79 f0 ff ff       	call   12d0 <puts@plt>
    2257:	8b 83 ec 07 00 00    	mov    0x7ec(%ebx),%eax
    225d:	8d 50 01             	lea    0x1(%eax),%edx
    2260:	89 93 ec 07 00 00    	mov    %edx,0x7ec(%ebx)
    2266:	6b c0 50             	imul   $0x50,%eax,%eax
    2269:	03 83 84 00 00 00    	add    0x84(%ebx),%eax
    226f:	8d b3 2f d5 ff ff    	lea    -0x2ad1(%ebx),%esi
    2275:	b9 04 00 00 00       	mov    $0x4,%ecx
    227a:	89 c7                	mov    %eax,%edi
    227c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    227e:	e8 36 fe ff ff       	call   20b9 <explode_bomb>

00002283 <phase_defused>:
    2283:	f3 0f 1e fb          	endbr32 
    2287:	53                   	push   %ebx
    2288:	83 ec 14             	sub    $0x14,%esp
    228b:	e8 a0 f1 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2290:	81 c3 c8 3c 00 00    	add    $0x3cc8,%ebx
    2296:	6a 01                	push   $0x1
    2298:	e8 3d fd ff ff       	call   1fda <send_msg>
    229d:	83 c4 10             	add    $0x10,%esp
    22a0:	83 bb ec 07 00 00 0b 	cmpl   $0xb,0x7ec(%ebx)
    22a7:	74 05                	je     22ae <phase_defused+0x2b>
    22a9:	83 c4 08             	add    $0x8,%esp
    22ac:	5b                   	pop    %ebx
    22ad:	c3                   	ret    
    22ae:	83 ec 0c             	sub    $0xc,%esp
    22b1:	8d 83 f4 d3 ff ff    	lea    -0x2c0c(%ebx),%eax
    22b7:	50                   	push   %eax
    22b8:	e8 13 f0 ff ff       	call   12d0 <puts@plt>
    22bd:	8d 83 20 d4 ff ff    	lea    -0x2be0(%ebx),%eax
    22c3:	89 04 24             	mov    %eax,(%esp)
    22c6:	e8 05 f0 ff ff       	call   12d0 <puts@plt>
    22cb:	83 c4 10             	add    $0x10,%esp
    22ce:	eb d9                	jmp    22a9 <phase_defused+0x26>

000022d0 <sigalrm_handler>:
    22d0:	f3 0f 1e fb          	endbr32 
    22d4:	53                   	push   %ebx
    22d5:	83 ec 08             	sub    $0x8,%esp
    22d8:	e8 53 f1 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    22dd:	81 c3 7b 3c 00 00    	add    $0x3c7b,%ebx
    22e3:	6a 00                	push   $0x0
    22e5:	8d 83 c8 d8 ff ff    	lea    -0x2738(%ebx),%eax
    22eb:	50                   	push   %eax
    22ec:	6a 01                	push   $0x1
    22ee:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
    22f4:	ff 30                	pushl  (%eax)
    22f6:	e8 85 f0 ff ff       	call   1380 <__fprintf_chk@plt>
    22fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2302:	e8 e9 ef ff ff       	call   12f0 <exit@plt>

00002307 <rio_readlineb>:
    2307:	55                   	push   %ebp
    2308:	57                   	push   %edi
    2309:	56                   	push   %esi
    230a:	53                   	push   %ebx
    230b:	83 ec 1c             	sub    $0x1c,%esp
    230e:	e8 1d f1 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2313:	81 c3 45 3c 00 00    	add    $0x3c45,%ebx
    2319:	89 d7                	mov    %edx,%edi
    231b:	83 f9 01             	cmp    $0x1,%ecx
    231e:	0f 86 87 00 00 00    	jbe    23ab <rio_readlineb+0xa4>
    2324:	89 c6                	mov    %eax,%esi
    2326:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
    232a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    232e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2335:	00 
    2336:	8d 6e 0c             	lea    0xc(%esi),%ebp
    2339:	eb 51                	jmp    238c <rio_readlineb+0x85>
    233b:	e8 10 f0 ff ff       	call   1350 <__errno_location@plt>
    2340:	83 38 04             	cmpl   $0x4,(%eax)
    2343:	75 50                	jne    2395 <rio_readlineb+0x8e>
    2345:	83 ec 04             	sub    $0x4,%esp
    2348:	68 00 20 00 00       	push   $0x2000
    234d:	55                   	push   %ebp
    234e:	ff 36                	pushl  (%esi)
    2350:	e8 cb ee ff ff       	call   1220 <read@plt>
    2355:	89 46 04             	mov    %eax,0x4(%esi)
    2358:	83 c4 10             	add    $0x10,%esp
    235b:	85 c0                	test   %eax,%eax
    235d:	78 dc                	js     233b <rio_readlineb+0x34>
    235f:	74 39                	je     239a <rio_readlineb+0x93>
    2361:	89 6e 08             	mov    %ebp,0x8(%esi)
    2364:	8b 56 08             	mov    0x8(%esi),%edx
    2367:	0f b6 0a             	movzbl (%edx),%ecx
    236a:	83 c2 01             	add    $0x1,%edx
    236d:	89 56 08             	mov    %edx,0x8(%esi)
    2370:	83 e8 01             	sub    $0x1,%eax
    2373:	89 46 04             	mov    %eax,0x4(%esi)
    2376:	83 c7 01             	add    $0x1,%edi
    2379:	88 4f ff             	mov    %cl,-0x1(%edi)
    237c:	80 f9 0a             	cmp    $0xa,%cl
    237f:	74 38                	je     23b9 <rio_readlineb+0xb2>
    2381:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
    2386:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
    238a:	74 29                	je     23b5 <rio_readlineb+0xae>
    238c:	8b 46 04             	mov    0x4(%esi),%eax
    238f:	85 c0                	test   %eax,%eax
    2391:	7e b2                	jle    2345 <rio_readlineb+0x3e>
    2393:	eb cf                	jmp    2364 <rio_readlineb+0x5d>
    2395:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    239a:	85 c0                	test   %eax,%eax
    239c:	75 2a                	jne    23c8 <rio_readlineb+0xc1>
    239e:	83 7c 24 08 01       	cmpl   $0x1,0x8(%esp)
    23a3:	75 14                	jne    23b9 <rio_readlineb+0xb2>
    23a5:	89 44 24 08          	mov    %eax,0x8(%esp)
    23a9:	eb 11                	jmp    23bc <rio_readlineb+0xb5>
    23ab:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    23b2:	00 
    23b3:	eb 04                	jmp    23b9 <rio_readlineb+0xb2>
    23b5:	8b 7c 24 0c          	mov    0xc(%esp),%edi
    23b9:	c6 07 00             	movb   $0x0,(%edi)
    23bc:	8b 44 24 08          	mov    0x8(%esp),%eax
    23c0:	83 c4 1c             	add    $0x1c,%esp
    23c3:	5b                   	pop    %ebx
    23c4:	5e                   	pop    %esi
    23c5:	5f                   	pop    %edi
    23c6:	5d                   	pop    %ebp
    23c7:	c3                   	ret    
    23c8:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
    23cf:	ff 
    23d0:	eb ea                	jmp    23bc <rio_readlineb+0xb5>

000023d2 <submitr>:
    23d2:	f3 0f 1e fb          	endbr32 
    23d6:	55                   	push   %ebp
    23d7:	57                   	push   %edi
    23d8:	56                   	push   %esi
    23d9:	53                   	push   %ebx
    23da:	8d 84 24 00 60 ff ff 	lea    -0xa000(%esp),%eax
    23e1:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    23e7:	83 0c 24 00          	orl    $0x0,(%esp)
    23eb:	39 c4                	cmp    %eax,%esp
    23ed:	75 f2                	jne    23e1 <submitr+0xf>
    23ef:	83 ec 60             	sub    $0x60,%esp
    23f2:	e8 39 f0 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    23f7:	81 c3 61 3b 00 00    	add    $0x3b61,%ebx
    23fd:	8b b4 24 74 a0 00 00 	mov    0xa074(%esp),%esi
    2404:	8b 84 24 7c a0 00 00 	mov    0xa07c(%esp),%eax
    240b:	89 44 24 0c          	mov    %eax,0xc(%esp)
    240f:	8b 84 24 80 a0 00 00 	mov    0xa080(%esp),%eax
    2416:	89 44 24 10          	mov    %eax,0x10(%esp)
    241a:	8b 84 24 84 a0 00 00 	mov    0xa084(%esp),%eax
    2421:	89 44 24 14          	mov    %eax,0x14(%esp)
    2425:	8b ac 24 88 a0 00 00 	mov    0xa088(%esp),%ebp
    242c:	8b 84 24 8c a0 00 00 	mov    0xa08c(%esp),%eax
    2433:	89 44 24 18          	mov    %eax,0x18(%esp)
    2437:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    243d:	89 84 24 50 a0 00 00 	mov    %eax,0xa050(%esp)
    2444:	31 c0                	xor    %eax,%eax
    2446:	c7 44 24 30 00 00 00 	movl   $0x0,0x30(%esp)
    244d:	00 
    244e:	6a 00                	push   $0x0
    2450:	6a 01                	push   $0x1
    2452:	6a 02                	push   $0x2
    2454:	e8 17 ef ff ff       	call   1370 <socket@plt>
    2459:	89 44 24 10          	mov    %eax,0x10(%esp)
    245d:	83 c4 10             	add    $0x10,%esp
    2460:	85 c0                	test   %eax,%eax
    2462:	0f 88 1c 01 00 00    	js     2584 <submitr+0x1b2>
    2468:	83 ec 0c             	sub    $0xc,%esp
    246b:	56                   	push   %esi
    246c:	e8 1f ef ff ff       	call   1390 <gethostbyname@plt>
    2471:	83 c4 10             	add    $0x10,%esp
    2474:	85 c0                	test   %eax,%eax
    2476:	0f 84 5a 01 00 00    	je     25d6 <submitr+0x204>
    247c:	8d 74 24 30          	lea    0x30(%esp),%esi
    2480:	c7 44 24 30 00 00 00 	movl   $0x0,0x30(%esp)
    2487:	00 
    2488:	c7 44 24 34 00 00 00 	movl   $0x0,0x34(%esp)
    248f:	00 
    2490:	c7 44 24 38 00 00 00 	movl   $0x0,0x38(%esp)
    2497:	00 
    2498:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%esp)
    249f:	00 
    24a0:	66 c7 44 24 30 02 00 	movw   $0x2,0x30(%esp)
    24a7:	6a 0c                	push   $0xc
    24a9:	ff 70 0c             	pushl  0xc(%eax)
    24ac:	8b 40 10             	mov    0x10(%eax),%eax
    24af:	ff 30                	pushl  (%eax)
    24b1:	8d 44 24 40          	lea    0x40(%esp),%eax
    24b5:	50                   	push   %eax
    24b6:	e8 25 ee ff ff       	call   12e0 <__memmove_chk@plt>
    24bb:	0f b7 84 24 84 a0 00 	movzwl 0xa084(%esp),%eax
    24c2:	00 
    24c3:	66 c1 c0 08          	rol    $0x8,%ax
    24c7:	66 89 44 24 42       	mov    %ax,0x42(%esp)
    24cc:	83 c4 0c             	add    $0xc,%esp
    24cf:	6a 10                	push   $0x10
    24d1:	56                   	push   %esi
    24d2:	ff 74 24 0c          	pushl  0xc(%esp)
    24d6:	e8 d5 ee ff ff       	call   13b0 <connect@plt>
    24db:	83 c4 10             	add    $0x10,%esp
    24de:	85 c0                	test   %eax,%eax
    24e0:	0f 88 63 01 00 00    	js     2649 <submitr+0x277>
    24e6:	be ff ff ff ff       	mov    $0xffffffff,%esi
    24eb:	b8 00 00 00 00       	mov    $0x0,%eax
    24f0:	89 f1                	mov    %esi,%ecx
    24f2:	89 ef                	mov    %ebp,%edi
    24f4:	f2 ae                	repnz scas %es:(%edi),%al
    24f6:	f7 d1                	not    %ecx
    24f8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    24fc:	89 f1                	mov    %esi,%ecx
    24fe:	8b 7c 24 08          	mov    0x8(%esp),%edi
    2502:	f2 ae                	repnz scas %es:(%edi),%al
    2504:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2508:	89 f1                	mov    %esi,%ecx
    250a:	8b 7c 24 0c          	mov    0xc(%esp),%edi
    250e:	f2 ae                	repnz scas %es:(%edi),%al
    2510:	89 ca                	mov    %ecx,%edx
    2512:	f7 d2                	not    %edx
    2514:	89 f1                	mov    %esi,%ecx
    2516:	8b 7c 24 10          	mov    0x10(%esp),%edi
    251a:	f2 ae                	repnz scas %es:(%edi),%al
    251c:	2b 54 24 18          	sub    0x18(%esp),%edx
    2520:	29 ca                	sub    %ecx,%edx
    2522:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    2526:	8d 44 49 fd          	lea    -0x3(%ecx,%ecx,2),%eax
    252a:	8d 44 02 7b          	lea    0x7b(%edx,%eax,1),%eax
    252e:	3d 00 20 00 00       	cmp    $0x2000,%eax
    2533:	0f 87 75 01 00 00    	ja     26ae <submitr+0x2dc>
    2539:	8d 94 24 4c 40 00 00 	lea    0x404c(%esp),%edx
    2540:	b9 00 08 00 00       	mov    $0x800,%ecx
    2545:	b8 00 00 00 00       	mov    $0x0,%eax
    254a:	89 d7                	mov    %edx,%edi
    254c:	f3 ab                	rep stos %eax,%es:(%edi)
    254e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    2553:	89 ef                	mov    %ebp,%edi
    2555:	f2 ae                	repnz scas %es:(%edi),%al
    2557:	f7 d1                	not    %ecx
    2559:	83 e9 01             	sub    $0x1,%ecx
    255c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2560:	0f 84 f6 04 00 00    	je     2a5c <submitr+0x68a>
    2566:	89 ee                	mov    %ebp,%esi
    2568:	89 d7                	mov    %edx,%edi
    256a:	8d 83 d2 d9 ff ff    	lea    -0x262e(%ebx),%eax
    2570:	89 44 24 18          	mov    %eax,0x18(%esp)
    2574:	8d 84 24 4c 80 00 00 	lea    0x804c(%esp),%eax
    257b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    257f:	e9 c2 01 00 00       	jmp    2746 <submitr+0x374>
    2584:	8b 44 24 14          	mov    0x14(%esp),%eax
    2588:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    258e:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
    2595:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
    259c:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
    25a3:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
    25aa:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
    25b1:	c7 40 18 63 72 65 61 	movl   $0x61657263,0x18(%eax)
    25b8:	c7 40 1c 74 65 20 73 	movl   $0x73206574,0x1c(%eax)
    25bf:	c7 40 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%eax)
    25c6:	66 c7 40 24 74 00    	movw   $0x74,0x24(%eax)
    25cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    25d1:	e9 36 03 00 00       	jmp    290c <submitr+0x53a>
    25d6:	8b 44 24 14          	mov    0x14(%esp),%eax
    25da:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    25e0:	c7 40 04 72 3a 20 44 	movl   $0x44203a72,0x4(%eax)
    25e7:	c7 40 08 4e 53 20 69 	movl   $0x6920534e,0x8(%eax)
    25ee:	c7 40 0c 73 20 75 6e 	movl   $0x6e752073,0xc(%eax)
    25f5:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
    25fc:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
    2603:	c7 40 18 72 65 73 6f 	movl   $0x6f736572,0x18(%eax)
    260a:	c7 40 1c 6c 76 65 20 	movl   $0x2065766c,0x1c(%eax)
    2611:	c7 40 20 73 65 72 76 	movl   $0x76726573,0x20(%eax)
    2618:	c7 40 24 65 72 20 61 	movl   $0x61207265,0x24(%eax)
    261f:	c7 40 28 64 64 72 65 	movl   $0x65726464,0x28(%eax)
    2626:	66 c7 40 2c 73 73    	movw   $0x7373,0x2c(%eax)
    262c:	c6 40 2e 00          	movb   $0x0,0x2e(%eax)
    2630:	83 ec 0c             	sub    $0xc,%esp
    2633:	ff 74 24 0c          	pushl  0xc(%esp)
    2637:	e8 84 ed ff ff       	call   13c0 <close@plt>
    263c:	83 c4 10             	add    $0x10,%esp
    263f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2644:	e9 c3 02 00 00       	jmp    290c <submitr+0x53a>
    2649:	8b 44 24 14          	mov    0x14(%esp),%eax
    264d:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    2653:	c7 40 04 72 3a 20 55 	movl   $0x55203a72,0x4(%eax)
    265a:	c7 40 08 6e 61 62 6c 	movl   $0x6c62616e,0x8(%eax)
    2661:	c7 40 0c 65 20 74 6f 	movl   $0x6f742065,0xc(%eax)
    2668:	c7 40 10 20 63 6f 6e 	movl   $0x6e6f6320,0x10(%eax)
    266f:	c7 40 14 6e 65 63 74 	movl   $0x7463656e,0x14(%eax)
    2676:	c7 40 18 20 74 6f 20 	movl   $0x206f7420,0x18(%eax)
    267d:	c7 40 1c 74 68 65 20 	movl   $0x20656874,0x1c(%eax)
    2684:	c7 40 20 73 65 72 76 	movl   $0x76726573,0x20(%eax)
    268b:	66 c7 40 24 65 72    	movw   $0x7265,0x24(%eax)
    2691:	c6 40 26 00          	movb   $0x0,0x26(%eax)
    2695:	83 ec 0c             	sub    $0xc,%esp
    2698:	ff 74 24 0c          	pushl  0xc(%esp)
    269c:	e8 1f ed ff ff       	call   13c0 <close@plt>
    26a1:	83 c4 10             	add    $0x10,%esp
    26a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    26a9:	e9 5e 02 00 00       	jmp    290c <submitr+0x53a>
    26ae:	8b 44 24 14          	mov    0x14(%esp),%eax
    26b2:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    26b8:	c7 40 04 72 3a 20 52 	movl   $0x52203a72,0x4(%eax)
    26bf:	c7 40 08 65 73 75 6c 	movl   $0x6c757365,0x8(%eax)
    26c6:	c7 40 0c 74 20 73 74 	movl   $0x74732074,0xc(%eax)
    26cd:	c7 40 10 72 69 6e 67 	movl   $0x676e6972,0x10(%eax)
    26d4:	c7 40 14 20 74 6f 6f 	movl   $0x6f6f7420,0x14(%eax)
    26db:	c7 40 18 20 6c 61 72 	movl   $0x72616c20,0x18(%eax)
    26e2:	c7 40 1c 67 65 2e 20 	movl   $0x202e6567,0x1c(%eax)
    26e9:	c7 40 20 49 6e 63 72 	movl   $0x72636e49,0x20(%eax)
    26f0:	c7 40 24 65 61 73 65 	movl   $0x65736165,0x24(%eax)
    26f7:	c7 40 28 20 53 55 42 	movl   $0x42555320,0x28(%eax)
    26fe:	c7 40 2c 4d 49 54 52 	movl   $0x5254494d,0x2c(%eax)
    2705:	c7 40 30 5f 4d 41 58 	movl   $0x58414d5f,0x30(%eax)
    270c:	c7 40 34 42 55 46 00 	movl   $0x465542,0x34(%eax)
    2713:	83 ec 0c             	sub    $0xc,%esp
    2716:	ff 74 24 0c          	pushl  0xc(%esp)
    271a:	e8 a1 ec ff ff       	call   13c0 <close@plt>
    271f:	83 c4 10             	add    $0x10,%esp
    2722:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2727:	e9 e0 01 00 00       	jmp    290c <submitr+0x53a>
    272c:	3c 5f                	cmp    $0x5f,%al
    272e:	75 7f                	jne    27af <submitr+0x3dd>
    2730:	88 07                	mov    %al,(%edi)
    2732:	8d 7f 01             	lea    0x1(%edi),%edi
    2735:	83 c6 01             	add    $0x1,%esi
    2738:	8b 44 24 04          	mov    0x4(%esp),%eax
    273c:	01 e8                	add    %ebp,%eax
    273e:	39 c6                	cmp    %eax,%esi
    2740:	0f 84 16 03 00 00    	je     2a5c <submitr+0x68a>
    2746:	0f b6 06             	movzbl (%esi),%eax
    2749:	8d 50 d6             	lea    -0x2a(%eax),%edx
    274c:	80 fa 0f             	cmp    $0xf,%dl
    274f:	77 db                	ja     272c <submitr+0x35a>
    2751:	b9 d9 ff 00 00       	mov    $0xffd9,%ecx
    2756:	0f a3 d1             	bt     %edx,%ecx
    2759:	72 d5                	jb     2730 <submitr+0x35e>
    275b:	3c 5f                	cmp    $0x5f,%al
    275d:	74 d1                	je     2730 <submitr+0x35e>
    275f:	8d 50 e0             	lea    -0x20(%eax),%edx
    2762:	80 fa 5f             	cmp    $0x5f,%dl
    2765:	76 08                	jbe    276f <submitr+0x39d>
    2767:	3c 09                	cmp    $0x9,%al
    2769:	0f 85 a3 02 00 00    	jne    2a12 <submitr+0x640>
    276f:	83 ec 0c             	sub    $0xc,%esp
    2772:	0f b6 c0             	movzbl %al,%eax
    2775:	50                   	push   %eax
    2776:	ff 74 24 28          	pushl  0x28(%esp)
    277a:	6a 08                	push   $0x8
    277c:	6a 01                	push   $0x1
    277e:	ff 74 24 38          	pushl  0x38(%esp)
    2782:	e8 59 ec ff ff       	call   13e0 <__sprintf_chk@plt>
    2787:	0f b6 84 24 6c 80 00 	movzbl 0x806c(%esp),%eax
    278e:	00 
    278f:	88 07                	mov    %al,(%edi)
    2791:	0f b6 84 24 6d 80 00 	movzbl 0x806d(%esp),%eax
    2798:	00 
    2799:	88 47 01             	mov    %al,0x1(%edi)
    279c:	0f b6 84 24 6e 80 00 	movzbl 0x806e(%esp),%eax
    27a3:	00 
    27a4:	88 47 02             	mov    %al,0x2(%edi)
    27a7:	83 c4 20             	add    $0x20,%esp
    27aa:	8d 7f 03             	lea    0x3(%edi),%edi
    27ad:	eb 86                	jmp    2735 <submitr+0x363>
    27af:	89 c2                	mov    %eax,%edx
    27b1:	83 e2 df             	and    $0xffffffdf,%edx
    27b4:	83 ea 41             	sub    $0x41,%edx
    27b7:	80 fa 19             	cmp    $0x19,%dl
    27ba:	0f 86 70 ff ff ff    	jbe    2730 <submitr+0x35e>
    27c0:	3c 20                	cmp    $0x20,%al
    27c2:	75 9b                	jne    275f <submitr+0x38d>
    27c4:	c6 07 2b             	movb   $0x2b,(%edi)
    27c7:	8d 7f 01             	lea    0x1(%edi),%edi
    27ca:	e9 66 ff ff ff       	jmp    2735 <submitr+0x363>
    27cf:	01 c5                	add    %eax,%ebp
    27d1:	29 c6                	sub    %eax,%esi
    27d3:	0f 84 da 02 00 00    	je     2ab3 <submitr+0x6e1>
    27d9:	83 ec 04             	sub    $0x4,%esp
    27dc:	56                   	push   %esi
    27dd:	55                   	push   %ebp
    27de:	ff 74 24 0c          	pushl  0xc(%esp)
    27e2:	e8 29 eb ff ff       	call   1310 <write@plt>
    27e7:	83 c4 10             	add    $0x10,%esp
    27ea:	85 c0                	test   %eax,%eax
    27ec:	7f e1                	jg     27cf <submitr+0x3fd>
    27ee:	e8 5d eb ff ff       	call   1350 <__errno_location@plt>
    27f3:	83 38 04             	cmpl   $0x4,(%eax)
    27f6:	0f 85 ad 01 00 00    	jne    29a9 <submitr+0x5d7>
    27fc:	89 f8                	mov    %edi,%eax
    27fe:	eb cf                	jmp    27cf <submitr+0x3fd>
    2800:	8b 44 24 14          	mov    0x14(%esp),%eax
    2804:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    280a:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
    2811:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
    2818:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
    281f:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
    2826:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
    282d:	c7 40 18 72 65 61 64 	movl   $0x64616572,0x18(%eax)
    2834:	c7 40 1c 20 66 69 72 	movl   $0x72696620,0x1c(%eax)
    283b:	c7 40 20 73 74 20 68 	movl   $0x68207473,0x20(%eax)
    2842:	c7 40 24 65 61 64 65 	movl   $0x65646165,0x24(%eax)
    2849:	c7 40 28 72 20 66 72 	movl   $0x72662072,0x28(%eax)
    2850:	c7 40 2c 6f 6d 20 73 	movl   $0x73206d6f,0x2c(%eax)
    2857:	c7 40 30 65 72 76 65 	movl   $0x65767265,0x30(%eax)
    285e:	66 c7 40 34 72 00    	movw   $0x72,0x34(%eax)
    2864:	83 ec 0c             	sub    $0xc,%esp
    2867:	ff 74 24 0c          	pushl  0xc(%esp)
    286b:	e8 50 eb ff ff       	call   13c0 <close@plt>
    2870:	83 c4 10             	add    $0x10,%esp
    2873:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2878:	e9 8f 00 00 00       	jmp    290c <submitr+0x53a>
    287d:	83 ec 08             	sub    $0x8,%esp
    2880:	8d 94 24 54 80 00 00 	lea    0x8054(%esp),%edx
    2887:	52                   	push   %edx
    2888:	50                   	push   %eax
    2889:	8d 83 ec d8 ff ff    	lea    -0x2714(%ebx),%eax
    288f:	50                   	push   %eax
    2890:	6a ff                	push   $0xffffffff
    2892:	6a 01                	push   $0x1
    2894:	ff 74 24 30          	pushl  0x30(%esp)
    2898:	e8 43 eb ff ff       	call   13e0 <__sprintf_chk@plt>
    289d:	83 c4 14             	add    $0x14,%esp
    28a0:	ff 74 24 0c          	pushl  0xc(%esp)
    28a4:	e8 17 eb ff ff       	call   13c0 <close@plt>
    28a9:	83 c4 10             	add    $0x10,%esp
    28ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    28b1:	eb 59                	jmp    290c <submitr+0x53a>
    28b3:	8d 94 24 4c 20 00 00 	lea    0x204c(%esp),%edx
    28ba:	8d 44 24 40          	lea    0x40(%esp),%eax
    28be:	b9 00 20 00 00       	mov    $0x2000,%ecx
    28c3:	e8 3f fa ff ff       	call   2307 <rio_readlineb>
    28c8:	85 c0                	test   %eax,%eax
    28ca:	7e 5f                	jle    292b <submitr+0x559>
    28cc:	83 ec 08             	sub    $0x8,%esp
    28cf:	8d 84 24 54 20 00 00 	lea    0x2054(%esp),%eax
    28d6:	50                   	push   %eax
    28d7:	8b 74 24 20          	mov    0x20(%esp),%esi
    28db:	56                   	push   %esi
    28dc:	e8 af e9 ff ff       	call   1290 <strcpy@plt>
    28e1:	83 c4 04             	add    $0x4,%esp
    28e4:	ff 74 24 0c          	pushl  0xc(%esp)
    28e8:	e8 d3 ea ff ff       	call   13c0 <close@plt>
    28ed:	b9 03 00 00 00       	mov    $0x3,%ecx
    28f2:	8d bb ed d9 ff ff    	lea    -0x2613(%ebx),%edi
    28f8:	f3 a6                	repz cmpsb %es:(%edi),%ds:(%esi)
    28fa:	0f 97 c0             	seta   %al
    28fd:	1c 00                	sbb    $0x0,%al
    28ff:	83 c4 10             	add    $0x10,%esp
    2902:	84 c0                	test   %al,%al
    2904:	0f 95 c0             	setne  %al
    2907:	0f b6 c0             	movzbl %al,%eax
    290a:	f7 d8                	neg    %eax
    290c:	8b 9c 24 4c a0 00 00 	mov    0xa04c(%esp),%ebx
    2913:	65 33 1d 14 00 00 00 	xor    %gs:0x14,%ebx
    291a:	0f 85 b8 02 00 00    	jne    2bd8 <submitr+0x806>
    2920:	81 c4 5c a0 00 00    	add    $0xa05c,%esp
    2926:	5b                   	pop    %ebx
    2927:	5e                   	pop    %esi
    2928:	5f                   	pop    %edi
    2929:	5d                   	pop    %ebp
    292a:	c3                   	ret    
    292b:	8b 44 24 14          	mov    0x14(%esp),%eax
    292f:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    2935:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
    293c:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
    2943:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
    294a:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
    2951:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
    2958:	c7 40 18 72 65 61 64 	movl   $0x64616572,0x18(%eax)
    295f:	c7 40 1c 20 73 74 61 	movl   $0x61747320,0x1c(%eax)
    2966:	c7 40 20 74 75 73 20 	movl   $0x20737574,0x20(%eax)
    296d:	c7 40 24 6d 65 73 73 	movl   $0x7373656d,0x24(%eax)
    2974:	c7 40 28 61 67 65 20 	movl   $0x20656761,0x28(%eax)
    297b:	c7 40 2c 66 72 6f 6d 	movl   $0x6d6f7266,0x2c(%eax)
    2982:	c7 40 30 20 73 65 72 	movl   $0x72657320,0x30(%eax)
    2989:	c7 40 34 76 65 72 00 	movl   $0x726576,0x34(%eax)
    2990:	83 ec 0c             	sub    $0xc,%esp
    2993:	ff 74 24 0c          	pushl  0xc(%esp)
    2997:	e8 24 ea ff ff       	call   13c0 <close@plt>
    299c:	83 c4 10             	add    $0x10,%esp
    299f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    29a4:	e9 63 ff ff ff       	jmp    290c <submitr+0x53a>
    29a9:	8b 44 24 14          	mov    0x14(%esp),%eax
    29ad:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    29b3:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
    29ba:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
    29c1:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
    29c8:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
    29cf:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
    29d6:	c7 40 18 77 72 69 74 	movl   $0x74697277,0x18(%eax)
    29dd:	c7 40 1c 65 20 74 6f 	movl   $0x6f742065,0x1c(%eax)
    29e4:	c7 40 20 20 74 68 65 	movl   $0x65687420,0x20(%eax)
    29eb:	c7 40 24 20 73 65 72 	movl   $0x72657320,0x24(%eax)
    29f2:	c7 40 28 76 65 72 00 	movl   $0x726576,0x28(%eax)
    29f9:	83 ec 0c             	sub    $0xc,%esp
    29fc:	ff 74 24 0c          	pushl  0xc(%esp)
    2a00:	e8 bb e9 ff ff       	call   13c0 <close@plt>
    2a05:	83 c4 10             	add    $0x10,%esp
    2a08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2a0d:	e9 fa fe ff ff       	jmp    290c <submitr+0x53a>
    2a12:	8b 83 1c d9 ff ff    	mov    -0x26e4(%ebx),%eax
    2a18:	8b 7c 24 14          	mov    0x14(%esp),%edi
    2a1c:	89 07                	mov    %eax,(%edi)
    2a1e:	8b 83 5b d9 ff ff    	mov    -0x26a5(%ebx),%eax
    2a24:	89 47 3f             	mov    %eax,0x3f(%edi)
    2a27:	89 f8                	mov    %edi,%eax
    2a29:	8d 7f 04             	lea    0x4(%edi),%edi
    2a2c:	83 e7 fc             	and    $0xfffffffc,%edi
    2a2f:	29 f8                	sub    %edi,%eax
    2a31:	8d b3 1c d9 ff ff    	lea    -0x26e4(%ebx),%esi
    2a37:	29 c6                	sub    %eax,%esi
    2a39:	83 c0 43             	add    $0x43,%eax
    2a3c:	c1 e8 02             	shr    $0x2,%eax
    2a3f:	89 c1                	mov    %eax,%ecx
    2a41:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    2a43:	83 ec 0c             	sub    $0xc,%esp
    2a46:	ff 74 24 0c          	pushl  0xc(%esp)
    2a4a:	e8 71 e9 ff ff       	call   13c0 <close@plt>
    2a4f:	83 c4 10             	add    $0x10,%esp
    2a52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2a57:	e9 b0 fe ff ff       	jmp    290c <submitr+0x53a>
    2a5c:	8d 84 24 4c 40 00 00 	lea    0x404c(%esp),%eax
    2a63:	50                   	push   %eax
    2a64:	ff 74 24 14          	pushl  0x14(%esp)
    2a68:	ff 74 24 14          	pushl  0x14(%esp)
    2a6c:	ff 74 24 14          	pushl  0x14(%esp)
    2a70:	8d 83 60 d9 ff ff    	lea    -0x26a0(%ebx),%eax
    2a76:	50                   	push   %eax
    2a77:	68 00 20 00 00       	push   $0x2000
    2a7c:	6a 01                	push   $0x1
    2a7e:	8d bc 24 68 20 00 00 	lea    0x2068(%esp),%edi
    2a85:	57                   	push   %edi
    2a86:	e8 55 e9 ff ff       	call   13e0 <__sprintf_chk@plt>
    2a8b:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    2a90:	b8 00 00 00 00       	mov    $0x0,%eax
    2a95:	f2 ae                	repnz scas %es:(%edi),%al
    2a97:	f7 d1                	not    %ecx
    2a99:	83 c4 20             	add    $0x20,%esp
    2a9c:	8d ac 24 4c 20 00 00 	lea    0x204c(%esp),%ebp
    2aa3:	bf 00 00 00 00       	mov    $0x0,%edi
    2aa8:	89 ce                	mov    %ecx,%esi
    2aaa:	83 ee 01             	sub    $0x1,%esi
    2aad:	0f 85 26 fd ff ff    	jne    27d9 <submitr+0x407>
    2ab3:	8b 04 24             	mov    (%esp),%eax
    2ab6:	89 44 24 40          	mov    %eax,0x40(%esp)
    2aba:	c7 44 24 44 00 00 00 	movl   $0x0,0x44(%esp)
    2ac1:	00 
    2ac2:	8d 44 24 40          	lea    0x40(%esp),%eax
    2ac6:	8d 54 24 4c          	lea    0x4c(%esp),%edx
    2aca:	89 54 24 48          	mov    %edx,0x48(%esp)
    2ace:	8d 94 24 4c 20 00 00 	lea    0x204c(%esp),%edx
    2ad5:	b9 00 20 00 00       	mov    $0x2000,%ecx
    2ada:	e8 28 f8 ff ff       	call   2307 <rio_readlineb>
    2adf:	85 c0                	test   %eax,%eax
    2ae1:	0f 8e 19 fd ff ff    	jle    2800 <submitr+0x42e>
    2ae7:	83 ec 0c             	sub    $0xc,%esp
    2aea:	8d 84 24 58 80 00 00 	lea    0x8058(%esp),%eax
    2af1:	50                   	push   %eax
    2af2:	8d 44 24 3c          	lea    0x3c(%esp),%eax
    2af6:	50                   	push   %eax
    2af7:	8d 84 24 60 60 00 00 	lea    0x6060(%esp),%eax
    2afe:	50                   	push   %eax
    2aff:	8d 83 d9 d9 ff ff    	lea    -0x2627(%ebx),%eax
    2b05:	50                   	push   %eax
    2b06:	8d 84 24 68 20 00 00 	lea    0x2068(%esp),%eax
    2b0d:	50                   	push   %eax
    2b0e:	e8 1d e8 ff ff       	call   1330 <__isoc99_sscanf@plt>
    2b13:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    2b17:	83 c4 20             	add    $0x20,%esp
    2b1a:	3d c8 00 00 00       	cmp    $0xc8,%eax
    2b1f:	0f 85 58 fd ff ff    	jne    287d <submitr+0x4ab>
    2b25:	8d ac 24 4c 20 00 00 	lea    0x204c(%esp),%ebp
    2b2c:	8d 83 ea d9 ff ff    	lea    -0x2616(%ebx),%eax
    2b32:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b36:	b9 03 00 00 00       	mov    $0x3,%ecx
    2b3b:	89 ee                	mov    %ebp,%esi
    2b3d:	8b 7c 24 04          	mov    0x4(%esp),%edi
    2b41:	f3 a6                	repz cmpsb %es:(%edi),%ds:(%esi)
    2b43:	0f 97 c0             	seta   %al
    2b46:	1c 00                	sbb    $0x0,%al
    2b48:	84 c0                	test   %al,%al
    2b4a:	0f 84 63 fd ff ff    	je     28b3 <submitr+0x4e1>
    2b50:	8d 44 24 40          	lea    0x40(%esp),%eax
    2b54:	b9 00 20 00 00       	mov    $0x2000,%ecx
    2b59:	89 ea                	mov    %ebp,%edx
    2b5b:	e8 a7 f7 ff ff       	call   2307 <rio_readlineb>
    2b60:	85 c0                	test   %eax,%eax
    2b62:	7f d2                	jg     2b36 <submitr+0x764>
    2b64:	8b 44 24 14          	mov    0x14(%esp),%eax
    2b68:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
    2b6e:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
    2b75:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
    2b7c:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
    2b83:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
    2b8a:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
    2b91:	c7 40 18 72 65 61 64 	movl   $0x64616572,0x18(%eax)
    2b98:	c7 40 1c 20 68 65 61 	movl   $0x61656820,0x1c(%eax)
    2b9f:	c7 40 20 64 65 72 73 	movl   $0x73726564,0x20(%eax)
    2ba6:	c7 40 24 20 66 72 6f 	movl   $0x6f726620,0x24(%eax)
    2bad:	c7 40 28 6d 20 73 65 	movl   $0x6573206d,0x28(%eax)
    2bb4:	c7 40 2c 72 76 65 72 	movl   $0x72657672,0x2c(%eax)
    2bbb:	c6 40 30 00          	movb   $0x0,0x30(%eax)
    2bbf:	83 ec 0c             	sub    $0xc,%esp
    2bc2:	ff 74 24 0c          	pushl  0xc(%esp)
    2bc6:	e8 f5 e7 ff ff       	call   13c0 <close@plt>
    2bcb:	83 c4 10             	add    $0x10,%esp
    2bce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2bd3:	e9 34 fd ff ff       	jmp    290c <submitr+0x53a>
    2bd8:	e8 63 03 00 00       	call   2f40 <__stack_chk_fail_local>

00002bdd <init_timeout>:
    2bdd:	f3 0f 1e fb          	endbr32 
    2be1:	56                   	push   %esi
    2be2:	53                   	push   %ebx
    2be3:	83 ec 04             	sub    $0x4,%esp
    2be6:	e8 45 e8 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2beb:	81 c3 6d 33 00 00    	add    $0x336d,%ebx
    2bf1:	8b 74 24 10          	mov    0x10(%esp),%esi
    2bf5:	85 f6                	test   %esi,%esi
    2bf7:	75 06                	jne    2bff <init_timeout+0x22>
    2bf9:	83 c4 04             	add    $0x4,%esp
    2bfc:	5b                   	pop    %ebx
    2bfd:	5e                   	pop    %esi
    2bfe:	c3                   	ret    
    2bff:	83 ec 08             	sub    $0x8,%esp
    2c02:	8d 83 78 c3 ff ff    	lea    -0x3c88(%ebx),%eax
    2c08:	50                   	push   %eax
    2c09:	6a 0e                	push   $0xe
    2c0b:	e8 40 e6 ff ff       	call   1250 <signal@plt>
    2c10:	85 f6                	test   %esi,%esi
    2c12:	b8 00 00 00 00       	mov    $0x0,%eax
    2c17:	0f 48 f0             	cmovs  %eax,%esi
    2c1a:	89 34 24             	mov    %esi,(%esp)
    2c1d:	e8 4e e6 ff ff       	call   1270 <alarm@plt>
    2c22:	83 c4 10             	add    $0x10,%esp
    2c25:	eb d2                	jmp    2bf9 <init_timeout+0x1c>

00002c27 <init_driver>:
    2c27:	f3 0f 1e fb          	endbr32 
    2c2b:	55                   	push   %ebp
    2c2c:	57                   	push   %edi
    2c2d:	56                   	push   %esi
    2c2e:	53                   	push   %ebx
    2c2f:	83 ec 34             	sub    $0x34,%esp
    2c32:	e8 f9 e7 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2c37:	81 c3 21 33 00 00    	add    $0x3321,%ebx
    2c3d:	8b 7c 24 48          	mov    0x48(%esp),%edi
    2c41:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
    2c47:	89 44 24 24          	mov    %eax,0x24(%esp)
    2c4b:	31 c0                	xor    %eax,%eax
    2c4d:	6a 01                	push   $0x1
    2c4f:	6a 0d                	push   $0xd
    2c51:	e8 fa e5 ff ff       	call   1250 <signal@plt>
    2c56:	83 c4 08             	add    $0x8,%esp
    2c59:	6a 01                	push   $0x1
    2c5b:	6a 1d                	push   $0x1d
    2c5d:	e8 ee e5 ff ff       	call   1250 <signal@plt>
    2c62:	83 c4 08             	add    $0x8,%esp
    2c65:	6a 01                	push   $0x1
    2c67:	6a 1d                	push   $0x1d
    2c69:	e8 e2 e5 ff ff       	call   1250 <signal@plt>
    2c6e:	83 c4 0c             	add    $0xc,%esp
    2c71:	6a 00                	push   $0x0
    2c73:	6a 01                	push   $0x1
    2c75:	6a 02                	push   $0x2
    2c77:	e8 f4 e6 ff ff       	call   1370 <socket@plt>
    2c7c:	83 c4 10             	add    $0x10,%esp
    2c7f:	85 c0                	test   %eax,%eax
    2c81:	0f 88 ac 00 00 00    	js     2d33 <init_driver+0x10c>
    2c87:	89 c6                	mov    %eax,%esi
    2c89:	83 ec 0c             	sub    $0xc,%esp
    2c8c:	8d 83 f0 d9 ff ff    	lea    -0x2610(%ebx),%eax
    2c92:	50                   	push   %eax
    2c93:	e8 f8 e6 ff ff       	call   1390 <gethostbyname@plt>
    2c98:	83 c4 10             	add    $0x10,%esp
    2c9b:	85 c0                	test   %eax,%eax
    2c9d:	0f 84 db 00 00 00    	je     2d7e <init_driver+0x157>
    2ca3:	8d 6c 24 0c          	lea    0xc(%esp),%ebp
    2ca7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2cae:	00 
    2caf:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    2cb6:	00 
    2cb7:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    2cbe:	00 
    2cbf:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2cc6:	00 
    2cc7:	66 c7 44 24 0c 02 00 	movw   $0x2,0xc(%esp)
    2cce:	6a 0c                	push   $0xc
    2cd0:	ff 70 0c             	pushl  0xc(%eax)
    2cd3:	8b 40 10             	mov    0x10(%eax),%eax
    2cd6:	ff 30                	pushl  (%eax)
    2cd8:	8d 44 24 1c          	lea    0x1c(%esp),%eax
    2cdc:	50                   	push   %eax
    2cdd:	e8 fe e5 ff ff       	call   12e0 <__memmove_chk@plt>
    2ce2:	66 c7 44 24 1e 43 31 	movw   $0x3143,0x1e(%esp)
    2ce9:	83 c4 0c             	add    $0xc,%esp
    2cec:	6a 10                	push   $0x10
    2cee:	55                   	push   %ebp
    2cef:	56                   	push   %esi
    2cf0:	e8 bb e6 ff ff       	call   13b0 <connect@plt>
    2cf5:	83 c4 10             	add    $0x10,%esp
    2cf8:	85 c0                	test   %eax,%eax
    2cfa:	0f 88 ea 00 00 00    	js     2dea <init_driver+0x1c3>
    2d00:	83 ec 0c             	sub    $0xc,%esp
    2d03:	56                   	push   %esi
    2d04:	e8 b7 e6 ff ff       	call   13c0 <close@plt>
    2d09:	66 c7 07 4f 4b       	movw   $0x4b4f,(%edi)
    2d0e:	c6 47 02 00          	movb   $0x0,0x2(%edi)
    2d12:	83 c4 10             	add    $0x10,%esp
    2d15:	b8 00 00 00 00       	mov    $0x0,%eax
    2d1a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    2d1e:	65 33 15 14 00 00 00 	xor    %gs:0x14,%edx
    2d25:	0f 85 f0 00 00 00    	jne    2e1b <init_driver+0x1f4>
    2d2b:	83 c4 2c             	add    $0x2c,%esp
    2d2e:	5b                   	pop    %ebx
    2d2f:	5e                   	pop    %esi
    2d30:	5f                   	pop    %edi
    2d31:	5d                   	pop    %ebp
    2d32:	c3                   	ret    
    2d33:	c7 07 45 72 72 6f    	movl   $0x6f727245,(%edi)
    2d39:	c7 47 04 72 3a 20 43 	movl   $0x43203a72,0x4(%edi)
    2d40:	c7 47 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%edi)
    2d47:	c7 47 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%edi)
    2d4e:	c7 47 10 61 62 6c 65 	movl   $0x656c6261,0x10(%edi)
    2d55:	c7 47 14 20 74 6f 20 	movl   $0x206f7420,0x14(%edi)
    2d5c:	c7 47 18 63 72 65 61 	movl   $0x61657263,0x18(%edi)
    2d63:	c7 47 1c 74 65 20 73 	movl   $0x73206574,0x1c(%edi)
    2d6a:	c7 47 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%edi)
    2d71:	66 c7 47 24 74 00    	movw   $0x74,0x24(%edi)
    2d77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2d7c:	eb 9c                	jmp    2d1a <init_driver+0xf3>
    2d7e:	c7 07 45 72 72 6f    	movl   $0x6f727245,(%edi)
    2d84:	c7 47 04 72 3a 20 44 	movl   $0x44203a72,0x4(%edi)
    2d8b:	c7 47 08 4e 53 20 69 	movl   $0x6920534e,0x8(%edi)
    2d92:	c7 47 0c 73 20 75 6e 	movl   $0x6e752073,0xc(%edi)
    2d99:	c7 47 10 61 62 6c 65 	movl   $0x656c6261,0x10(%edi)
    2da0:	c7 47 14 20 74 6f 20 	movl   $0x206f7420,0x14(%edi)
    2da7:	c7 47 18 72 65 73 6f 	movl   $0x6f736572,0x18(%edi)
    2dae:	c7 47 1c 6c 76 65 20 	movl   $0x2065766c,0x1c(%edi)
    2db5:	c7 47 20 73 65 72 76 	movl   $0x76726573,0x20(%edi)
    2dbc:	c7 47 24 65 72 20 61 	movl   $0x61207265,0x24(%edi)
    2dc3:	c7 47 28 64 64 72 65 	movl   $0x65726464,0x28(%edi)
    2dca:	66 c7 47 2c 73 73    	movw   $0x7373,0x2c(%edi)
    2dd0:	c6 47 2e 00          	movb   $0x0,0x2e(%edi)
    2dd4:	83 ec 0c             	sub    $0xc,%esp
    2dd7:	56                   	push   %esi
    2dd8:	e8 e3 e5 ff ff       	call   13c0 <close@plt>
    2ddd:	83 c4 10             	add    $0x10,%esp
    2de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2de5:	e9 30 ff ff ff       	jmp    2d1a <init_driver+0xf3>
    2dea:	83 ec 0c             	sub    $0xc,%esp
    2ded:	8d 83 f0 d9 ff ff    	lea    -0x2610(%ebx),%eax
    2df3:	50                   	push   %eax
    2df4:	8d 83 ac d9 ff ff    	lea    -0x2654(%ebx),%eax
    2dfa:	50                   	push   %eax
    2dfb:	6a ff                	push   $0xffffffff
    2dfd:	6a 01                	push   $0x1
    2dff:	57                   	push   %edi
    2e00:	e8 db e5 ff ff       	call   13e0 <__sprintf_chk@plt>
    2e05:	83 c4 14             	add    $0x14,%esp
    2e08:	56                   	push   %esi
    2e09:	e8 b2 e5 ff ff       	call   13c0 <close@plt>
    2e0e:	83 c4 10             	add    $0x10,%esp
    2e11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2e16:	e9 ff fe ff ff       	jmp    2d1a <init_driver+0xf3>
    2e1b:	e8 20 01 00 00       	call   2f40 <__stack_chk_fail_local>

00002e20 <driver_post>:
    2e20:	f3 0f 1e fb          	endbr32 
    2e24:	56                   	push   %esi
    2e25:	53                   	push   %ebx
    2e26:	83 ec 04             	sub    $0x4,%esp
    2e29:	e8 02 e6 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2e2e:	81 c3 2a 31 00 00    	add    $0x312a,%ebx
    2e34:	8b 54 24 10          	mov    0x10(%esp),%edx
    2e38:	8b 44 24 18          	mov    0x18(%esp),%eax
    2e3c:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    2e40:	85 c0                	test   %eax,%eax
    2e42:	75 18                	jne    2e5c <driver_post+0x3c>
    2e44:	85 d2                	test   %edx,%edx
    2e46:	74 05                	je     2e4d <driver_post+0x2d>
    2e48:	80 3a 00             	cmpb   $0x0,(%edx)
    2e4b:	75 37                	jne    2e84 <driver_post+0x64>
    2e4d:	66 c7 06 4f 4b       	movw   $0x4b4f,(%esi)
    2e52:	c6 46 02 00          	movb   $0x0,0x2(%esi)
    2e56:	83 c4 04             	add    $0x4,%esp
    2e59:	5b                   	pop    %ebx
    2e5a:	5e                   	pop    %esi
    2e5b:	c3                   	ret    
    2e5c:	83 ec 04             	sub    $0x4,%esp
    2e5f:	ff 74 24 18          	pushl  0x18(%esp)
    2e63:	8d 83 07 da ff ff    	lea    -0x25f9(%ebx),%eax
    2e69:	50                   	push   %eax
    2e6a:	6a 01                	push   $0x1
    2e6c:	e8 ef e4 ff ff       	call   1360 <__printf_chk@plt>
    2e71:	66 c7 06 4f 4b       	movw   $0x4b4f,(%esi)
    2e76:	c6 46 02 00          	movb   $0x0,0x2(%esi)
    2e7a:	83 c4 10             	add    $0x10,%esp
    2e7d:	b8 00 00 00 00       	mov    $0x0,%eax
    2e82:	eb d2                	jmp    2e56 <driver_post+0x36>
    2e84:	83 ec 04             	sub    $0x4,%esp
    2e87:	56                   	push   %esi
    2e88:	ff 74 24 1c          	pushl  0x1c(%esp)
    2e8c:	8d 83 1e da ff ff    	lea    -0x25e2(%ebx),%eax
    2e92:	50                   	push   %eax
    2e93:	52                   	push   %edx
    2e94:	8d 83 2a da ff ff    	lea    -0x25d6(%ebx),%eax
    2e9a:	50                   	push   %eax
    2e9b:	68 31 43 00 00       	push   $0x4331
    2ea0:	8d 83 f0 d9 ff ff    	lea    -0x2610(%ebx),%eax
    2ea6:	50                   	push   %eax
    2ea7:	e8 26 f5 ff ff       	call   23d2 <submitr>
    2eac:	83 c4 20             	add    $0x20,%esp
    2eaf:	eb a5                	jmp    2e56 <driver_post+0x36>
    2eb1:	66 90                	xchg   %ax,%ax
    2eb3:	66 90                	xchg   %ax,%ax
    2eb5:	66 90                	xchg   %ax,%ax
    2eb7:	66 90                	xchg   %ax,%ax
    2eb9:	66 90                	xchg   %ax,%ax
    2ebb:	66 90                	xchg   %ax,%ax
    2ebd:	66 90                	xchg   %ax,%ax
    2ebf:	90                   	nop

00002ec0 <__libc_csu_init>:
    2ec0:	f3 0f 1e fb          	endbr32 
    2ec4:	55                   	push   %ebp
    2ec5:	e8 6b 00 00 00       	call   2f35 <__x86.get_pc_thunk.bp>
    2eca:	81 c5 8e 30 00 00    	add    $0x308e,%ebp
    2ed0:	57                   	push   %edi
    2ed1:	56                   	push   %esi
    2ed2:	53                   	push   %ebx
    2ed3:	83 ec 0c             	sub    $0xc,%esp
    2ed6:	89 eb                	mov    %ebp,%ebx
    2ed8:	8b 7c 24 28          	mov    0x28(%esp),%edi
    2edc:	e8 1f e1 ff ff       	call   1000 <_init>
    2ee1:	8d 9d 04 ff ff ff    	lea    -0xfc(%ebp),%ebx
    2ee7:	8d 85 00 ff ff ff    	lea    -0x100(%ebp),%eax
    2eed:	29 c3                	sub    %eax,%ebx
    2eef:	c1 fb 02             	sar    $0x2,%ebx
    2ef2:	74 29                	je     2f1d <__libc_csu_init+0x5d>
    2ef4:	31 f6                	xor    %esi,%esi
    2ef6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2efd:	8d 76 00             	lea    0x0(%esi),%esi
    2f00:	83 ec 04             	sub    $0x4,%esp
    2f03:	57                   	push   %edi
    2f04:	ff 74 24 2c          	pushl  0x2c(%esp)
    2f08:	ff 74 24 2c          	pushl  0x2c(%esp)
    2f0c:	ff 94 b5 00 ff ff ff 	call   *-0x100(%ebp,%esi,4)
    2f13:	83 c6 01             	add    $0x1,%esi
    2f16:	83 c4 10             	add    $0x10,%esp
    2f19:	39 f3                	cmp    %esi,%ebx
    2f1b:	75 e3                	jne    2f00 <__libc_csu_init+0x40>
    2f1d:	83 c4 0c             	add    $0xc,%esp
    2f20:	5b                   	pop    %ebx
    2f21:	5e                   	pop    %esi
    2f22:	5f                   	pop    %edi
    2f23:	5d                   	pop    %ebp
    2f24:	c3                   	ret    
    2f25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002f30 <__libc_csu_fini>:
    2f30:	f3 0f 1e fb          	endbr32 
    2f34:	c3                   	ret    

00002f35 <__x86.get_pc_thunk.bp>:
    2f35:	8b 2c 24             	mov    (%esp),%ebp
    2f38:	c3                   	ret    
    2f39:	66 90                	xchg   %ax,%ax
    2f3b:	66 90                	xchg   %ax,%ax
    2f3d:	66 90                	xchg   %ax,%ax
    2f3f:	90                   	nop

00002f40 <__stack_chk_fail_local>:
    2f40:	f3 0f 1e fb          	endbr32 
    2f44:	53                   	push   %ebx
    2f45:	e8 e6 e4 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2f4a:	81 c3 0e 30 00 00    	add    $0x300e,%ebx
    2f50:	83 ec 08             	sub    $0x8,%esp
    2f53:	e8 28 e3 ff ff       	call   1280 <__stack_chk_fail@plt>

Disassembly of section .fini:

00002f58 <_fini>:
    2f58:	f3 0f 1e fb          	endbr32 
    2f5c:	53                   	push   %ebx
    2f5d:	83 ec 08             	sub    $0x8,%esp
    2f60:	e8 cb e4 ff ff       	call   1430 <__x86.get_pc_thunk.bx>
    2f65:	81 c3 f3 2f 00 00    	add    $0x2ff3,%ebx
    2f6b:	83 c4 08             	add    $0x8,%esp
    2f6e:	5b                   	pop    %ebx
    2f6f:	c3                   	ret    
