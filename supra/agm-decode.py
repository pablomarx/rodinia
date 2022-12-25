#!/usr/bin/python3

import sys

sub_inputs = [
	"5Lw`\tj &N\\b!g{*?qSv9RJ+7X1hI'kMr%>-/Zp<HE@e_=(a$0,BWtnOdVfyK}YAG[mUT^D;46xcQs)CP~iz].3l82o\"|:Fu#",
	"BAt]*2<uWMeQKnE4HcI |6GiS#~D`_C?/$j\t0w[J}lORkZ^V@'fpy=;zm7%)LroNgP+X-h(3TU8{q,5b&d9!>av:.s\\1Y\"Fx",
	"W-6cIZ\\/D}P[|$%@z3Ta\t1QH gdq!_x#J0KG=,.UYvtp&*iC4VjXeuEn7ws`5+~?SylNhrM;('{:>^8<mAkbOoL]fB2F9R)\"",
	"s\")/]fiB4LFjZ0:en*$dltoz(}q!K;72g5%\tW|91yPQE+h6_r=> .\\HSGRY#uwTU?vCa8,@<IOV[-M&`JpA~k3cb{N^X'mxD",
	"oL|mj!>inA90VH=<w[}P^,K~Q_{. \\&:6(X]`4?kuN$ds8%E/qDYUx@Z2Mlt;'p5Ic3*CTRaWr1Fybfe-GvJ)zh\tBgO#+7\"S",
	"Y7|03;,+sOm\t#oy-1j*5`p'D@NG4A[IRz8iM9WUe:\"bkcVh{^nS>$uPf/aqE.JT)6Zt<BF?!]L}H=g%_Q(wXdr 2~l\\C&xKv",
	"fsc37NaBn}\"L%:.,\\TkoiZ1 #p?Sz^JbC'8<6Wey;9*drgG=w_0l2RI(Q!]5vq~F$-V{/A&t+DxMuOUE>[|Y`@hXH)\tj4KmP",
	"{mD~tv0\"i\tM.5? YGx|SfJ_l)[=^X<LOe2h}W(]a8Rc\\pF-NU'V6n79@,rZ%BszuH/gAd$oE:Qy#>`KI+q&Tk3!wj1C4;P*b",
	"euAI~?'S8E_OiLomnV>\"r&Qs(1}$fytTG%a90@3Pb7gw\\ h\tC-jHUz,[dlB4RJX#cFD!+Z|]K^)k*`6{p<=Nx;2q5MW.v:Y/",
	"c%\"rhuK`Y1_O<b:>6Xf(H^Ag\\Dl2/En5z)];eQp-~|!wNko9R\t@VvLtTa?qZ{G[+'&8JWB$,=i7x IC#d4sU.0*PM3jSym}F",
	"6%GpfN<o5tQ2:s1/F#0Aa,$rhq\\X8IB[J^x&P({YVSn>9+~!c)u]W}we=MLDv'`O\"@3CH 4KT7|Uzily?_.EdR-bgZ;k\tmj*",
	"NCmj6?eL\tiuIEg]2Z#8~a&3*/xR)nV_0Xv+TYyPWohqzM:k,\"{G;b .!w4}dpr^$QJ9Af1'U[D-%7c5\\`(B>=lK<@Ss|HOtF",
	"v07W%pThNDQyPH`A:o>Lk'/tZK^\tG|q?3b(*@FY#Md-Xim+s}94J[E.cr]lBO~IR5w;&j6C\"U8{\\e$gV!), 2Su<a_=fzn1x",
	"#Hr0)~KUBR_4V`g]h[mzeA&wxdLu;-sZoFDIk%Ci?> Q/lTS7$EJW.\t\\M+*=<n}ct9Oq5{8YP2j(\"X:v'b1yfNap63^,|!G@",
	"?v_nV*L< 8J1`e7r6}A9/iqYj4Mz!@0b'xl:52a>m)F{H$ytwchS3B+g[,W](oX=U;RQPI^&TZ-s.%#Df\\~EdNuOK|k\"GC\tp",
	"\"WY\t:{Zc/jlb$q Tg+-`N@!U2&_*Mt|HI6evoFuA3Bx](hR)Q0LpD\\Xd<PEs9?Or[^1,'Sy5.f=%mV}Kz#78;>CkiJwG4na~",
	"?TUzX|J:F~7yCap-2t'&bALv \"`Dnm8OH{%kc,P4#=Ke/^}\t[lG93Niw*EjY;VRW)1oQgdr.@fSZs0!$5h<B](I>M_u\\+xq6",
	"&S}fOv#iu\t*)^l|FbB!Z2Vr`~R'CdpK5zP0h?XMn\\<j=D,xAq_@WHega[LQ\"T;tcY1m/$78{y%s.IoG]>4 (-wJE9+kNU6:3",
	"52(>Q7E4)}$o X=rBz+n;vRMiLqpu~Hf1P\\3OATd#:mxj&^yh[CU<?|*9!kes8-t_%0Jw{\tGc'Kl/]N`YWFabSZ,6gV.D@\"I",
	"JynrL])|Tjc^uS&@b+$<ZlG/[%p=(P!aNd84D?#*e7tO\\{2RVUig3;,mK9_qz\t>xEH01W`:CvYs- Af.hIwXQ5}6kM~Fo'B\"",
	"t&~u+@E<^Xz:wOB2,L3=9s0RIY\"\\.5je>k?)CVqWF\tTG`yarh6D8*fl![SpMHdQ}Uv( -n|K;g#'mcJ4b%]_A7o/N${i1xPZ",
	"tQa3Ynl8q1&dUPH9RJ0<V%yuec|:_b-*M\"{BETg[vxC$;j2\\~wm@N7?h`OFiXpAW.6/fz4s,I}>5 k(+K!#)G^\t]'S=rZoDL",
	"X3^bk.5?|@7COi6GAIe&qRu\"})x#,Q\tn= +l]gB$4J%0cMYF>_N9Z;f'Th<`D*~2r/asd{tv-y!z([1\\KUpHLoPWVjS8E:wm",
	"lRNJH \"^ZGB#!A-ELn8j?CO\\*|<c4i1W':$r\tu9Sy.,2FdU+a5>P}3=@&Qx_M6pqD7bg0kVvem/sY{;[]X)fT(`hoIKw~%tz",
	"D39\\Q V4tGg*+eC0jHn;E\tklMrS-F[@Uzi6=':)v8d/PLq#b,Y.Z]Bx>mO<f{~(u}wy?125&o^!\"Ish%|cA7p_W$KX`RaTJN",
	"hgFUl{D]7pSPiC(\"G>/We}*xwyY5s29-@T+|qZJ`Q~6.nkM Xt%B?cOv$[!zV\\AIH=4,R<r8j_':K)#1u;^E3LboNma\tfd&0",
	"N=ScYXIF9otQ,Lsq{f0!_2-8&Timph#WHyM/ew(K)'l^Gx;EV]1*@\"r$Z>JBO.<Cg%dP?D4+j3R:kU\tbn|u~\\75`a[zA}v6 ",
	"^%Ax?q~pac\"E'fI6eyjl7ZQ+u@\tgRhk;})mC9t/:ivs5{K3$#rw W=X]_<>nUJ,2*\\FNM0o1B.[-&bGDH48YP(|Tz`!VdSOL",
	"sy-zVYx.WS[%C&{BM?foT8mZk]n\")P=wa#952}HpG1gE'~+b;K$hc:l\t*u 0,_N>6Ai!|v(Jqe@^QU7OXDt3LFR`4jI/rd<\\",
	",{C|i:a9~(1hQ\\rH][RzB/VKL4v`\tNjO@8oZsq TwkbFGuWf7d+UYM\"Jcgl-6X_$}!E2>.^Sm*x?#;3P=e<I0&nDA'yp)5%t",
	"H\"V,mv.=RWG;c%yM`1g&tN/qI[u)n<K42L7J >D(3B-}h+:o$_@89i~'wbdOeCEl^#S0\\sX\t{5U]p6rjkZF!?QazxAY|TfP*",
	"Qvx]f#4|{JT+wBg*d2HZlX~%!ht@6-}Fjb_r ^`7oPD$'m)Y\".RWa1N=<:?\\n8,Gke9I\tuES>i3yMzVC5[(&0qUp/;cLsAKO",
	":1q}&MZLBYG@hWIbARm+)#5z]dc \tij,l!e/pU[rt*J(V{?P.=%68wK>EQ9\"TOaxvF\\0sS4-CyHDX$|^_nkNu<g327`';of~",
	"-V$X0=J.w`lj\"\\CyiHg)4E>;q'oR8{ScLf#hz1KpP7~InY[s}k6WMN|!bB+m@vD5U*a_&u(]<2T3t: A?,x\tQZr%deO^GF9/",
	"'0@Kbx$q&Yz%?!kvo~IHdy`u}J=BsU-wn\"{M5ZP[*Q7:8,G<_]aX CLiT+6/V9(hclN1SjpDAEr\\\tO32e).4R|tW^#;f>Fmg",
	"<Bmy\t;f~:5Wrq/gjovYa0#QTRwJ?{SlD xI']F.-b)6kdN\\An8%(9*K+!u3Xt^&O4=E_L`zh2MGP}p$c1Us|,7VZi\"@[eCH>",
	"K\\y93c6\"(n-l|^je#;{$=A*.qXIF7Qu81d+)sr2]G<[:'!xD5hW,L~pV0Cog@JzvfSkm\t}&/UBb%EtZ_P`R?MiT4>wHa YON",
	"wYoV#5=OfRX;y`*au\tK):<kr $_0^?4zW2}>E8Nm6chd'@Fn,HJ\"%jB7A{M!s3Z[xg|i+]I-G/CP9bqDUv1l&.(STQtpL\\e~",
	"<C_6~Jwz+U):eW]P2\\?kx@V05s^8-7q.{LfG(Q1AlKpn[I!Y=9$o;`rdgmZh,\">F\t4TiMD%BE* t/#c}ya&X|'SN3bORHuvj",
	",Fn(`+UDQ0ok{[bWl!t-]r}9'?.V\\\t~C5Ixjg36mNZf2RXa<hPwi/=>4YJz MOEsd^$#7_S%@\"A*KqeyB&Gv;|u8)cT1LHp:",
	"%aC|YD&wm0e~d:R5sK$HG\"Puzt)_\\.fWcp!iJy^hQX\t{ #M8?bS/l6EqIUk1A@=;jox>(FvL-3`V9g]72'TON*rnZ<[B,4+}",
	"_wk!v]g,XxSJ&%/@rufF}4Tp2t5d=a9h1qM7N>{+P)^iAY$|8(-'IR:?\tU\"G L6;~.0mjVE`O[bK*Z<cWD\\o#QBsyzlnHeC3",
	"}qk$\"{/y=DOe]V_h@BJxF(u[P'65t8C 4:g-#zIWRG9+Mia\\|<fZ0Tvw?H1Q%2jpSd;.)oNb~l&s!,A>7Y3`^cXE*m\tnLKrU",
	"m4uPN~he+rA=)Bcq!5$1F*@Rp'xO<JdXbDl[i{}%k3UK^s8(Zg2VG:E.I_-\tC\"6&ynL\\ twv?]o|fW>,a/Mj0T#;z7YHQS`9",
	"'nDZx9I0WL4h1TO._ctlAsw+;p,v8/z^@>&USi*yj]dE5H#-R3\":!$\\K e|QmC`N{7YruV?}F)Jg%qPbG[k6BaX\t(M<o=2f~",
	"uO:+-}>r3n^gSjDv5;w/\t|LmG~URT*Y&7?%X\\$xMPoWI ,'({8QHal_N@z\"C<q!J=0#sV6[tekdK`).F]b29BpZhfy1EiAc4",
	"+]@Osgm$Y;v.?fhXaJy)L0k}=VquKW^9!xN\"{\tj AbipF<-|TC>Ql#zIB[:G2`DR~\\/8Ud47&_*wr%ZcP'e6(S35HMnEo1,t",
	";Km|MBN@Cz\tuq.=Q{rlVR-D0?W<&s2pFIew(yjtYhcG,U6/f][b`9x\"PkA+1a#o^'~gv4d>O_X8:T3*7JHEiS!%nZL\\}5$) ",
	"Z~m(|A{H 3N#:Gej[/.QL}C5T&,B_=+lJ'<S?dIy;YE\t$R6v%@w0u!gafUstxWb^]Fcn1Mzi42>-*VKOPD8ophX\\7q)`\"kr9",
	"QcGAIld$ ]E/=~UNFPpz|R\\tm>Wno\"J}b8v)!^0uZ:4X;2@k%D1#_'iBrw.\tx(y?OMT7<gKC[5,h&9YfS6q-{3jHaV`*Lse+",
	"-v6[hPKZLw\"\t1f`,J/_u=d|i8@}&M!rC2VFn:B.'Dc%<y+A4YE~H];3XgRTU)Olob9$m#G>zQW7aekI^(p?x5{s\\j tq*SN0",
	",Rk/?QK`PO+\"zJe]v3iIm7^fT*[85V@4)yr&uwY9n><-p\\.HAaDLUCNs0dtj%gZ{}(2o6:GE$|'Xx_=c !FWlMB1hq\tb~;S#",
	"<uP^%N(!was{Giq[6By}e+`Z,F_hO\t$JVf:X* I8gktnUCdv1S3T@/z\"2Q~b&#rAo';W?|>Yj-57H0LRlKE49cM).mD=\\]px",
	"g3n<cw]=ipXl8)NG7?u5vzRdBHA+(9;^Wykf[x*qm\"2&_J,>.CU\\SZ1PhatoVQj|~DI-M#:`!}6b\tTresOL%4E FKY{$@/0'",
	"9ASV?(q-gOEsZX]Ra7}H\\Kh#,PeuG8$IrUv<pTQ c=bdN)w/_{5^@\"f[x&y0z3:iL\tD.m2`4Y%l>kFWoM6B|1nt!*j~'+;CJ",
	"a=f[)<-x^tj@M&`\\9Lw!mvpZk(*U$uH}lCY6:>48S31VA,X_F|WGB{\"'y;~r5NOn0DTP+qKRc/eQbh]zJg%oEi?#7 ds\tI.2",
	"EC/$i\\D'N(}<MPO7gzHTt%]Q)`:mW_#Z5X,bV1L@aAIx62RFev B~hjfK&ny;\"l?U=09!4YuG|-Sq.dr*oc3[>^k8pJs{+\tw",
	"?I7UJ=CZ([xk6n havW0zqQ-G>|!j;fm$\\#A@&Rbg~:plt29.%DK<Bs^P`'d*+}r1]o3e4OMXL)5Nc,HySVYu8w_E{\"/i\tTF",
	"h97yH8;$%)Cjm!\tlrD\\_JWB' b6u5>^t*Kp\"|:QGR}Az&i<M-T`3.L[{PafSsdovExg~(kY#FN/0+X?]IOZwncq,@41=2eVU",
	"37OUK%&ktFudw61'SZTVgL\\$C2!hl;_jixYWr~M,D)cvJs0?:\"f @e/BAXzbE9{R#*p8|`+o]Gn\tP-=Ha(<y[>Qq}I4^.N5m",
	"}N\\Ir&$0oX'l{c>H-T;n86skw,h43A?[m YjqQ!@5]a=%(:DbGiJzU+W9~pOtL7CF`1g_Bx^E2K|\"Z\tyMP</.#)R*vVudSef",
	"v@70wqUOYdisM1-\\TPVre8Z2`!&NoHj;/6b.f{D\"(IugA^9Cp$xLcam<nyF}B\th4WJl] )3%tzk[?R,K=|XGQ+#>'*E5~:S_",
	"%\t>C\\vBW|/{9XSUt+&3}ZeFdzaPusH2M[?6x7kp_q~Dc:04n`Nfg8\"]AO)JyYhGiT<VImRb(jQ1.'ro5E$w ^L@!,l=K;*-#",
	"Tv&8-:l|pr>\"j4+dD{< 2Ky0Hgc\\WUhi}Ye,oQ?nAO!z/9.\t3MCu@;q`^tL$'Fw(xP=]_SR*ENJmIf15%X)sZGa#bk[6B~V7",
	"0xk`Dbdh6=.9[A;uSO)#JPV7_+j zCe&gE/14>-8QU@miIX^tn%Hp<fRZw(,q\\|}raKB~s'M!3T:F?Y5$LN*GylW\t2\"{voc]",
	"Ioyk 0'ux\"N_+r*\\VX:jhv\tH29]KU.4O{QPn%6}al`[sYC$JT;M=87?@iwf1<m^A-RGSqpB&F>tD)Z!,WE~c3#/z(5Lbed|g",
	"Xg\"^o]j)1I=;\t4:ZWG>pO!E~ew7J\\i@xQ`|2NLRz5F*{YVK0ql}nsB(D#.$hTPuM[,3-Hkra?m9UtS8C6+v<%_'b/& cyfdA",
	"#\"CrFqsbK Qd,hR.o]x5*H\t>j&mf8wu$\\-DBJkG<gVYZ;^6I:(SWLvM9`O2'!a0t%|Tpye=[+1P{3n~Ui/7N@zclA}E_)X?4",
	":1r|~aXt04I9vV,[kW$/z](Ef;sPd#ABbN>_}`!C?7JQj@p^cilGoR.\\F+-T *S=e6%Ouh<M3K&qw285gDU'yZ\"xH\tL{Y)mn",
	"1\"_PFtX<g3G9/'?.o-aLYBiC{7`JT,@\\c0V> 2n|Iy58r%w!;uR]dKpDO^WHx\tsj~zqQ+#UZM*S}$mEv6A4e)lbh(=k&[N:f",
	"C^<\"-7RA@lwkGTYx\tU.&j_f0v{)ScdDq>=H:F3VmNZh\\ Xi`%/W6]Lrybu;!g2,([Je$951'+Isn*Ktz~EO?4p|aQ#Bo}M8P",
	"MHi6)N]1\ta8yTf_(K@eO|>usZ9LA}~Y[+$4BcxSbr2P&R%m:#J<zCt.dw\"\\7;U/hDFV!`WqlGpQ,35X'*ko?Ev0=-jIn^{ g",
	"7i'4OBL2NZ~a_Snk3!s}T/5(hFGz*@`$f?Ycg %]PHbWDt.vx&:rEM=6o#-|Q>J+qy1l0U8C[9K^\\Vp;j,dX\"wmeA\t{<R)uI",
	"|.S*RaqE-\\<Kl^#{>x\t}rf+sFe@y$='~67up8d5%njJNU Ig!3zmZ12c0[PtY/Cko_`bwi:AhDBT&X)HQMWG,;9L\"4Vv]O?(",
	"rl\"`Kj<uNF*cPe7'm\t2;f/MbC0xEaHQ$=O-R(Asi]5_:tZz|d6Ip9>[U8& L@)}%+{y,D4#n~ohwSqWV1JgBX!Yv?T\\k.^3G",
	"\"F#oXcnIr5E1 0?q$7Mv(@3B;w\tlmybH[8|d`k=~'u\\*&<Z_RCA/^hxJ,>N-aTPps6}LifG{.DKeYQ)W29g]4+:j!OS%tzVU",
	"\tfUCIN.d%a2~*}ou?]P'J3h5&RKk1j)qv8XsgVwn[O-;,\"#6790xSy(r4`$Z_cA ^/zWm@FYpB\\=QeHTlG:+{!MLbt|<iDE>",
	"!/eGY2vo'$yA.x\\-7[8&B\t6(=*jmfLH15lP<~N?w9; h^Jd{,C>sIS}kEqn4rp`DUt@%cKu_\"baMV+:igZz]QXR#0|TF3)WO",
	"|KX[yAYf<k^I1se_3&?-L8ijh#40cW'5%N,p+2t@DHMP`{SoOEB/wV}*xbTG6Z (:>rU7z~q\"Fm]JdlQv\t=C;!$uRng\\9a).",
	"R6jHx?O 5Crid2-4Eq:b7v<QS3aVT)UfG@=M^9&IXJ'Kc[A_nD/P!0yo*~Y{%u.>th\"]BW\\F8k$;ezs#w,l1Zp}gNL+`|m(\t",
	"=n3qK{dL9]\\GhC|ySHXu,Ec'<# ($k7xNZ*O[JIYrlavQsP)U8T%0`\"&^Fi1VoA2Bmw/5fRz?g+~-}>t.;j!bD:6@pe4M_\tW",
	"y5k7JgV3e^bc[ZAh;'L6v29%/K~uOHq{wd?*+&f\t`C8(,G.YTx|nN!o#S-$:P}0lXW>4R<1=FI_ \"p]mrz@t\\D)BaMjEsUQi",
	"!S=QtU5T9;w3gF:Z(M2nkWvp*m'|{x-JLa#rPBf)e <j$N0s8XbE7~I\\Gh1/Dd&%Rl?q.][C+,YV>4^uO\"K}@HoAi\tc6yz`_",
	"i<Zc\\>;:k$ D~5.P`=%-o}z*TC,^!&NFj4E1x3dIwpbe_/)|S]a'Jlt8m+nRG0rA{BhQ?fus(LyV2#HgY9@XqK76O\"WMUv[\t",
	"N\tDiB]CWlqKJst:)FaA(O+Vn*fe8%z&x7<@4I-Mdv3jGEyT${2>.r#~\\0k=\"P[u1^L6c`R,}Sp/'m h|Q_!bHoU?gX9Y5Zw;",
	"-y#]YSd_V8nMb2QHx.K&Oc~DN6=W{*h u9RX7CUgzZpFt4J%`1m@/jq<+AkoliG'r^}\">I,;Ts($!P?:\\w|)vfBaL[E5\t0e3",
	"@QL\\3\"j)2O'V6KsxWMt+1rfin}{C>S8_P9&TRDqch/`|p:y.oXU<!umZ0Y?a$dlIH #k[g^e\t57*%J]G~w,-(FB=bvE;AzN4",
	"j(amG_l+trN\"{Rc@0nf>u-oA32?9b]}XD!dT<kh|U=y`&WI^MCQ\\PY\te7 LS8'FEwvs);O$x4K#Jq%./~i,g[:zVZ*561HpB",
	"Z<&XMR->c^Kjfsy~G\t\\.!Y4H5wx17Bq)p[*ON`{ :g29IeA=Pu_($Cl/+t%L\"Uvob]@}n6;aFDdJ,T#?hm8SVi'r0|Qkz3WE",
	",`dT<C\"MK&G~.S7{]U5zDu9ohY=F0IaOR8ksx'n\\%m|pP/;t1brc#wg3^@E\tel:Q*>+NyBAvW(Z 4i[6$L-Xf!2}?q_H)JjV",
	"<a(4V{9%bEc'\\d3@NY_.;fWIL! j~SGg}mD+p*hquo`T&O$HB\"[KQ>\ttRz=2i5|JP^)M/#70vlAF:wyknexX8?U1]C,r6-sZ",
	"4wS#$sNz~3nKF<dc6o\"WX@Z-p;']t^Tv{EAyqI+:,|7RmG%}e)MB[`b9k2UQr&f5Vi_HYCO\t?g(.uJlh \\L1*>Pj8D0a!x/=",
	"eVlD\\-yFud#~,)Jb(5P_={'LpY:/}G`BW&Z1.kT[\"j2UQr><|$i^3A49z6wa]!cf\tS07o%@+H?CKIOMNm8 ;RnqtxgEhvsX*",
	"pUwd1j&NmAx9@XlSZz)oM|`e-u{!45%E=GO>QLB(r\"$gqYRyKVCIk0sH~7\t?F;iPn+#b<2^['a*:_D8W/v6TJ.\\}h]3t c,f",
	"+zs!1&rgfe9N|U`%lmQ}TV^{\tGXj3c /$M8yqh0va-(?~I>P2\\.JOt_[nD:YW';dLFRZ=)p4iHuSx6E@7<\"B,kwbA#5C*]Ko",
	"L5vID\"=+w U%Bncb6a7[Hg`-<XysR/^dWx~\\f_J!{PVE}$e:KCh.&GSjq;183|r>Z(*pzlu9kti@m,Oo0NAQT4M\tY2]?)#'F",
	"E\t3s,cH;2%9fd4Fu\"=QvJ]|:L75KrPe*W$@)[T6\\l^yDoB&R>A'Yn(/SX#! gq-M~w{ka_Vjzb<?pU}Z0m`8ht+1GNI.iCOx",
	",L9\\[{1V<7s2iB!G \".}=&0XlmW'^|QK6I+#Tw:8rE)DdbgYnvz34(k_;MZ$HPe]cC*O@%f?`Uj\t/y-5pRFS>h~NoJtqAaxu",
	"?YI6JAFZ\tS->%cH8X2t/aTPi C[G^nV~RK`_sE$;vzd!rx@0'qUf,DL.]*N}=\"y(W3oewulg7pO<{+Q&m:bj9k5B#|4M)1h\\",
	"ZFf\\jkTgH0+di6M.DtA2{<W[8O# x=SC$%BI9uXNs_@bq7pU^'we\t,hPcKa:V*ov()R>-]zG|;51rylm&LJ`?~Q/!\"Y3n4E}"
]

sub_output = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~ \t"

sub_input_idx = 0
sub_input_seed = 0
sub_input_seed_advance = "EZez\n"

with open(sys.argv[1], "r") as input_file:
    data = input_file.read()
    result = ""
    for char in data:
        sub_input = sub_inputs[sub_input_idx]
        if char not in sub_input:
            result += char
        else:
            sub_output_idx = sub_input.index(char)
            char = sub_output[sub_output_idx]
            result += char
        
        if char in sub_input_seed_advance:
            sub_input_seed += 1
            sub_input_idx = (((((sub_input_seed * 113) + 79) % 13) * 47 + 53) % len(sub_inputs))
    
    print(result)