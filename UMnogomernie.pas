unit UMnogomernie;

interface

Type
  DinMas = Array of Real;
  DDinMas = Array of DinMas;

Procedure NedlerMid(length:word; alf,gam,bet,eps:real; DelProg:Word; var k:word);
Procedure XykDhivs(length:word; eps:real; DelProg:Word; var k:word);
Procedure Ovrashnii(Lmd,koef,eps:real; DelProg:Word; var k:word);
Procedure NaiskorSpysk(eps:real; DelProg:Word; Grad:boolean; var k:word);

Var
  X0,X1,X2:dinMas;       {Симплекс}
  F0,F1,F2:real;
  Xh:dinMas;          {Наивысшая вершина}
  Xn2:dinMas;         {Центр тяжести симплекса}
  Xn3:dinMas;         {Отраженные пременные}
  Y: DDinMas;
  XhGr,X1Gr:DinMas;        {Для вывода}  
  YGr:DDinMas;             {Для вывода}
  Par:byte;           {Параметры}
  ParXykDhivs:byte;
  OptimGrad,SpyskBol,GradSopr:boolean;
  ConstLmd:real;
  BolBarierGr,BolShtrafGr:boolean;
  LengthTest:word; {Длинна массива устранения зацикливания}

implementation

Uses Uform,SysUtils,Graphics,UOdnomernie,UShtrBarCurs;

Procedure Proverka(F,X1,X2:real; var Max,Min,X1h,X2h,X1L,X2L:real);
begin
  If F>Max then
    begin
    Max:=F;
    X1h:=X1;
    X2h:=X2;
    end;
  if F<Min then
    begin
    Min:=F;
    X1L:=X1;
    X2L:=X2;
    end;
end;


Procedure NedlerMid(length:word; alf,gam,bet,eps:real; DelProg:Word; var k:word);
  const
    Ksi = 0.5;
    a = 1;
    KolVrash =1;
  var
  XL:dinMas;          {Наименьшая вершина}
  Xn4:DinMas;         {Растянутые перемнные}
  Xn5:DinMas;         {Сжатые перемнные}
  Fh,FL,Fn2,Fn3,Fn4,Fn5:real; {Значение функции в точках}
  i:word;
  Exit,Next,Cik:Boolean;    {управляющие переменные}
  st,st1,st2:string;                {Таблица}
  Cur,New:PObList;          {Списки}
  YgolVrashN,YgolVrashK:real;
  Kb:word;

    Procedure VivodBSK(X:DinMas);
    begin
    If ((BolShtraf) or (BolBarier)) and (not BolKurs) then
      begin
      If k<>1 then
        Form1.StringGrid4.RowCount:=K+1;
      Form1.StringGrid4.Cells[0,k]:=IntToStr(K);
      Str(X[0]:4:3,st);
      Str(X[1]:4:3,st1);
      VivodGraphic:=true;
      Str(FX12(X[0],X[1],false,0):8:6,st2);
      VivodGraphic:=false;
      Form1.StringGrid4.Cells[1,k]:='('+st+'; '+st1+')='+st2;
      Str(FX12(X[0],X[1],false,0):8:6,st);
      Form1.StringGrid4.Cells[4,k]:=st;
      end
    else
    If (BolKurs) then
      begin
      If k<>1 then
        Form1.StringGrid5.RowCount:=K+1;
      Form1.StringGrid5.Cells[0,k]:=IntToStr(K);
      Str(Y[0][0]:4:3,st);
      Str(Y[0][1]:4:3,st1);
      VivodGraphic:=True;
      Str(FX12(Y[0][0],Y[0][1],false,0):10:6,st2);
      VivodGraphic:=false;
      Form1.StringGrid5.Cells[1,k]:='('+st+'; '+st1+')='+st2;
      end;
   If (BolShtraf) and (not BolKurs) then
      begin
      Str(Mu1:4:3,st);
      Form1.StringGrid4.Cells[2,k]:=st;
      Str(Mu1*Ogr1:4:3,st);
      Form1.StringGrid4.Cells[3,k]:=st;
      end;
    if (BolBarier) and (not BolKurs) then
      begin
      Str(Mu2:4:3,st);
      Form1.StringGrid4.Cells[2,k]:=st;
      Str(Mu2*Ogr2:4:3,st);
      Form1.StringGrid4.Cells[3,k]:=st;
      end;
    if BolKurs then
      begin
      Str(Mu1:4:3,st);
      Form1.StringGrid5.Cells[2,k]:=st;
      Str(Mu1*Ogr1:4:3,st);
      Form1.StringGrid5.Cells[3,k]:=st;
      Str(Mu2:4:3,st);
      Form1.StringGrid5.Cells[4,k]:=st;
      Str(Mu2*Ogr2:4:3,st);
      Form1.StringGrid5.Cells[5,k]:=st;
      end;
    end;

  Procedure Perestroika(var X:dinMas; Xn:dinMas; Var F:real; Fn:real);
    var
    i:word;
    begin
    If (X[0]=Xh[0]) and (X[1]=Xh[1]) then
      begin
      For i:=0 to length-1 do
        X[i]:=Xn[i];
      F:=Fn;
      end;
    end;

  Procedure PerestroikaAll(Xn:DinMas; Fn:real);
    begin
    Perestroika(X0,Xn,F0,Fn);
    Perestroika(X1,Xn,F1,Fn);
    Perestroika(X2,Xn,F2,Fn);
    end;

  procedure Vrashenie(Alfa:real);
    var
    X:DinMas;
    i:word;
    begin
    SetLength(X,Length);
    If (X0[0]=Xh[0]) and (X0[1]=Xh[1]) then
      begin
      X[0]:=Cos(Alfa/180*pi)*X1[0]-Sin(Alfa/180*pi)*X1[1];
      X[1]:=Sin(Alfa/180*pi)*X1[0]+Cos(Alfa/180*pi)*X1[1];
      X1[0]:=X[0];
      X1[1]:=X[1];
      X[0]:=Cos(Alfa/180*pi)*X2[0]-Sin(Alfa/180*pi)*X2[1];
      X[1]:=Sin(Alfa/180*pi)*X2[0]+Cos(Alfa/180*pi)*X2[1];
      X2[0]:=X[0];
      X2[1]:=X[1];
      end;
    If (X1[0]=Xh[0]) and (X1[1]=Xh[1]) then
      begin
      X[0]:=Cos(Alfa/180*pi)*X0[0]-Sin(Alfa/180*pi)*X0[1];
      X[1]:=Sin(Alfa/180*pi)*X0[0]+Cos(Alfa/180*pi)*X0[1];
      X0[0]:=X[0];
      X0[1]:=X[1];
      X[0]:=Cos(Alfa/180*pi)*X2[0]-Sin(Alfa/180*pi)*X2[1];
      X[1]:=Sin(Alfa/180*pi)*X2[0]+Cos(Alfa/180*pi)*X2[1];
      X2[0]:=X[0];
      X2[1]:=X[1];
      end;
    If (X2[0]=Xh[0]) and (X2[1]=Xh[1]) then
      begin
      X[0]:=Cos(Alfa/180*pi)*X1[0]-Sin(Alfa/180*pi)*X1[1];
      X[1]:=Sin(Alfa/180*pi)*X1[0]+Cos(Alfa/180*pi)*X1[1];
      X1[0]:=X[0];
      X1[1]:=X[1];
      X[0]:=Cos(Alfa/180*pi)*X0[0]-Sin(Alfa/180*pi)*X0[1];
      X[1]:=Sin(Alfa/180*pi)*X0[0]+Cos(Alfa/180*pi)*X0[1];
      X0[0]:=X[0];
      X0[1]:=X[1];
      end;
    F0:=FX12(X0[0],X0[1],true,DelProg);
    Fh:=F0;
    For i:=0 to length-1 do
      Xh[i]:=X0[i];
    FL:=Fh;
    For i:=0 to length-1 do
      XL[i]:=X0[i];
    F1:=FX12(X1[0],X1[1],true,DelProg);
    Proverka(F1,X1[0],X1[1],Fh,FL,Xh[0],Xh[1],XL[0],XL[1]);
    F2:=FX12(X2[0],X2[1],true,DelProg);
    Proverka(F2,X2[0],X2[1],Fh,FL,Xh[0],Xh[1],XL[0],XL[1]);
    For i:=0 to length-1 do
      begin
      Xn2[i]:=1/2*(X0[i]+X1[i]+X2[i]-Xh[i]);
      Xn3[i]:=Xn2[i]+alf*(Xn2[i]-Xh[i]);
      end;
    end;

  begin
    Cur:=HeadList;
  While Cur.Next<>nil do
    Cur:=Cur.Next;
  New:=PObList.Create(IntToStr(KolList)+'). Недлер-Мид '+FloatToStr(X0[0])+' '+FloatToStr(X0[1]));
  Cur.Next:=New;
  Inc(KolList);
  {Вычисление Начального симплекса}
  k:=0;
  SetLength(X1,Length);  SetLength(X2,Length);  SetLength(Xh,Length);  SetLength(XL,Length);
  SetLength(Xn2,Length);  SetLength(Xn3,Length);

  {симплекс 1}
  X1[0]:=X0[0]+a*Cos(30/180*pi);
  X1[1]:=X0[1]+a*Sin(30/180*pi);
  X2[0]:=X0[0]+a*Cos(30/180*pi);
  X2[1]:=X0[1]-a*Sin(30/180*pi);

  {Симплекс 2}
 { X1[0]:=X0[0];
  X1[1]:=X0[1]+a;
  X2[0]:=X0[0]+a*Cos(60/180*pi);
  X2[1]:=X0[1]+a*Sin(60/180*pi);}

  {Вычисления значения функций симнлекса}
  F0:=FX12(X0[0],X0[1],true,DelProg);
  F1:=FX12(X1[0],X1[1],true,DelProg);
  F2:=FX12(X2[0],X2[1],true,DelProg);

  repeat
    inc(k);

    {Вычисления значения функций Xh,Xl}
    Fh:=F0;
    For i:=0 to length-1 do
      Xh[i]:=X0[i];
    FL:=Fh;
    For i:=0 to length-1 do
      XL[i]:=X0[i];
    Proverka(F1,X1[0],X1[1],Fh,FL,Xh[0],Xh[1],XL[0],XL[1]);
    Proverka(F2,X2[0],X2[1],Fh,FL,Xh[0],Xh[1],XL[0],XL[1]);

    Next:=false;
    For i:=0 to length-1 do
      begin
      {Центр Тяжести}
      Xn2[i]:=1/2*(X0[i]+X1[i]+X2[i]-Xh[i]);
      {Отражение}
      Xn3[i]:=Xn2[i]+alf*(Xn2[i]-Xh[i]);
      end;

    {Поворот}
    If (Form1.ClbParam.Checked[0]) and (K mod Kolvrash =0) then
      begin
      YgolVrashN:=-45;
      YgolVrashK:=45;
      Dihotomii(YgolVrashN,YgolVrashK,Epsilon,2.5*Epsilon,0,False,Kb);
      Vrashenie(YgolVrashN+(YgolVrashK-YgolVrashN)/2);
      end;

    Fn2:=FX12(Xn2[0],Xn2[1],true,DelProg);
    Fn3:=FX12(Xn3[0],Xn3[1],true,DelProg);

    {Графический вывод симплекса}
    AddList(New,X0[0],X0[1],X1[0],X1[1],'',Form1.CbMu.Selected);
    AddList(New,X1[0],X1[1],X2[0],X2[1],'',Form1.CbMu.Selected);
    AddList(New,X0[0],X0[1],X2[0],X2[1],IntToStr(k),Form1.CbMu.Selected);

    If k<>1 then
      Form1.StringGrid2.RowCount:=k+1;
    Str(k,st);
    Form1.StringGrid2.Cells[0,k]:=st;
    Str(X0[0]:4:3,st);
    Str(X0[1]:4:3,st1);
    Str(F0:6:3,st2);
    Form1.StringGrid2.Cells[1,k]:='('+st+'; '+st1+')='+st2;
    Str(X1[0]:4:3,st);
    Str(X1[1]:4:3,st1);
    Str(F1:6:3,st2);
    Form1.StringGrid2.Cells[2,k]:='('+st+'; '+st1+')='+st2;
    Str(X2[0]:4:3,st);
    Str(X2[1]:4:3,st1);
    Str(F2:6:3,st2);
    Form1.StringGrid2.Cells[3,k]:='('+st+'; '+st1+')='+st2;
    Str(Xh[0]:4:3,st);
    Str(Xh[1]:4:3,st1);
    Form1.StringGrid2.Cells[4,k]:='('+st+'; '+st1+')';
    Str(XL[0]:4:3,st);
    Str(XL[1]:4:3,st1);
    Form1.StringGrid2.Cells[5,k]:='('+st+'; '+st1+')';
    Str(Xn2[0]:4:3,st);
    Str(Xn2[1]:4:3,st1);
    Str(Fn2:6:3,st2);
    Form1.StringGrid2.Cells[6,k]:='('+st+'; '+st1+')='+st2;
    Str(Xn3[0]:4:3,st);
    Str(Xn3[1]:4:3,st1);
    Str(Fn3:6:3,st2);
    Form1.StringGrid2.Cells[7,k]:='('+st+'; '+st1+')='+st2;

    If Fn3<FL then
      begin
      {Растяжение}
      {Оптимизация}
      If Form1.ClbParam.Checked[2] then
        begin
        YgolVrashN:=2;
        YgolVrashK:=5;
        Dihotomii(YgolVrashN,YgolVrashK,Epsilon,2.5*Epsilon,0,False,Kb);
        Gam:=YgolVrashN;
        end;

      SetLength(Xn4,Length);
      For i:=0 to length-1 do
        Xn4[i]:=Xn2[i]+gam*(Xn3[i]-Xn2[i]);
      Fn4:=FX12(Xn4[0],Xn4[1],true,DelProg);

      Str(Xn4[0]:4:3,st);
      Str(Xn4[1]:4:3,st1);
      Str(Fn4:6:3,st2);
      Form1.StringGrid2.Cells[8,k]:='('+st+'; '+st1+')='+st2;


      if Fn4<FL then
        begin
        PerestroikaAll(Xn4,Fn4);
        VivodBSK(Xn4);
        end
      else
        begin
        PerestroikaAll(Xn3,Fn3);
        VivodBSK(Xn3);
        end;
      Next:=true;
      end;
    If (not Next) and not (
       not ((X0[0]=Xh[0]) and (X0[1]=Xh[1])) and (Fn3<F0) or
       not ((X1[0]=Xh[0]) and (X1[1]=Xh[1])) and (Fn3<F1) or
       not ((X2[0]=Xh[0]) and (X2[1]=Xh[1])) and (Fn3<F2) )then
      begin
      {Сжатие}

      If Form1.ClbParam.Checked[3] then
        begin
        YgolVrashN:=0.4;
        YgolVrashK:=0.6;
        Dihotomii(YgolVrashN,YgolVrashK,Epsilon,2.5*Epsilon,0,False,Kb);
        bet:=YgolVrashN;
        end;

      SetLength(Xn5,Length);
      For i:=0 to length-1 do
        Xn5[i]:=Xn2[i]-bet*(Xh[i]-Xn2[i]);
      Fn5:=FX12(Xn5[0],Xn5[1],true,DelProg);

      Str(Xn5[0]:4:3,st);
      Str(Xn5[1]:4:3,st1);
      Str(Fn5:6:3,st2);
      Form1.StringGrid2.Cells[9,k]:='('+st+'; '+st1+')='+st2;

      if Fn5>Fh then
        begin
        PerestroikaAll(Xn5,Fn5);
        VivodBSK(Xn5);
        end
      else
      {Редукция}
      begin
      If Form1.ClbParam.Checked[1] then
        begin
        YgolVrashN:=-45;
        YgolVrashK:=45;
        Dihotomii(YgolVrashN,YgolVrashK,Epsilon,2.5*Epsilon,0,False,Kb);
        Vrashenie((YgolVrashK-YgolVrashN)/2)
        end;
      For i:=0 to length-1 do
        begin
        X0[i]:=XL[i]+Ksi*(X0[i]-XL[i]);
        X1[i]:=XL[i]+Ksi*(X1[i]-XL[i]);
        X2[i]:=XL[i]+Ksi*(X2[i]-XL[i]);
        end;
      F0:=FX12(X0[0],X0[1],true,DelProg);
      F1:=FX12(X1[0],X1[1],true,DelProg);
      F2:=FX12(X2[0],X2[1],true,DelProg);
      VivodBSK(X0);
      end;
      next:=true;
    end;
    If Not Next then
      begin
      PerestroikaAll(Xn3,Fn3);
      VivodBSK(Xn3);
      end;
    If Form1.RgMetod.ItemIndex=1 then
      begin
      Exit:=true;
      if Sqrt(1/3*(Sqr(F0-Fn2)+Sqr(F1-Fn2)+Sqr(F2-Fn2)))>Eps then
        Exit:=false;
      end
    else
      begin
      
      end;
  until Exit;
  end;

Procedure XykDhivs(length:word; eps:real; DelProg:Word; var k:word);
  Const
    DecInt=5;
  var
  Lmd:DinMas;
  i,z,j:word;
  exit:Boolean;
  NLmd,KLmd:real;
  st,st1,st2:string;
  kb:word;
  Cur,New:PObList;          {Списки}
  Znak:real;
  F,FNext:real;
  Fxk,Fx:real;
  Test:DDinMas; {Для уменьшения интервала неопределенности}
  NomTest:word; {Позиция}
  NomInt:word; {Для устраненеия выхода за ограничение}

  Procedure VivodBSK;
    begin
    If ((BolShtraf) or (BolBarier)) and (not BolKurs) then
      begin
      If k<>1 then
        Form1.StringGrid4.RowCount:=K+1;
      Form1.StringGrid4.Cells[0,k]:=IntToStr(K);
      Str(Y[0][0]:4:3,st);
      Str(Y[0][1]:4:3,st1);
      VivodGraphic:=true;
      Str(FX12(Y[0][0],Y[0][1],false,0):10:6,st2);
      VivodGraphic:=false;
      Form1.StringGrid4.Cells[1,k]:='('+st+'; '+st1+')='+st2;
      Str(FX:10:6,st);
      Form1.StringGrid4.Cells[4,k]:=st;
      end
    else
    If (BolKurs) then
      begin
      If k<>1 then
        Form1.StringGrid5.RowCount:=K+1;
      Form1.StringGrid5.Cells[0,k]:=IntToStr(K);
      Str(Y[0][0]:4:3,st);
      Str(Y[0][1]:4:3,st1);
      VivodGraphic:=True;
      Str(FX12(Y[0][0],Y[0][1],false,0):10:6,st2);
      VivodGraphic:=false;
      Form1.StringGrid5.Cells[1,k]:='('+st+'; '+st1+')='+st2;
      Str(FX:10:6,st);
      Form1.StringGrid5.Cells[6,k]:=st;
      end;
   If (BolShtraf) and (not BolKurs) then
      begin
      Str(Mu1:4:3,st);
      Form1.StringGrid4.Cells[2,k]:=st;
      Str(Mu1*Ogr1:4:3,st);
      Form1.StringGrid4.Cells[3,k]:=st;
      end;
    if (BolBarier) and (not BolKurs) then
      begin
      Str(Mu2:4:3,st);
      Form1.StringGrid4.Cells[2,k]:=st;
      Str(Mu2*Ogr2:4:3,st);
      Form1.StringGrid4.Cells[3,k]:=st;
      end;
    if BolKurs then
      begin
      Str(Mu1:4:3,st);
      Form1.StringGrid5.Cells[2,k]:=st;
      Str(Mu1*Ogr1:4:3,st);
      Form1.StringGrid5.Cells[3,k]:=st;
      Str(Mu2:4:3,st);
      Form1.StringGrid5.Cells[4,k]:=st;
      Str(Mu2*Ogr2:4:3,st);
      Form1.StringGrid5.Cells[5,k]:=st;
      end;
    end;

  Procedure FN;
    begin
    if j=0 then
      FNext:=FX12(Y[j][0]+Lmd[j]+Znak*Eps/2,Y[j][1],true,delProg)
    else
      Fnext:=FX12(Y[j][0],Y[j][1]+Lmd[j]+Znak*Eps/2,true,delProg);
    end;

  begin
{  if not BolKurs then
    begin              }
    Cur:=HeadList;
    While Cur.Next<>nil do
      Cur:=Cur.Next;
    New:=PObList.Create(IntToStr(KolList)+'). Хук-Дживс '+FloatToStr(X0[0])+' '+FloatToStr(X0[1]));
    Cur.Next:=New;
    Inc(KOlList);
    addList(New,X0[0]+0.1,X0[1]+0.1,X0[0]-0.1,X0[1]-0.1,'Нач',clRed);
    addList(New,X0[0]-0.1,X0[1]+0.1,X0[0]+0.1,X0[1]-0.1,'',clRed);
{    end
  else
    New:=ListCurs;   }
  if not BolKurs then
    begin
    k:=1;
    ConstLmd:=10;
    end;
  If Form1.ClbParamS.Checked[4] then
    begin
    Setlength(Test,LengthTest);
    For i:=0 to LengthTest-1 do
      begin
      SetLength(Test[i],Length);
      For j:=1 to Length-1 do
      Test[i][j]:=X0[j];
      end;
    end;
  Setlength(Y,Length+1);
  For i:=0 to length do
    SetLength(Y[i],Length);
  For i:=0 to Length-1 do
    Y[0][i]:=X0[i];
  SetLength(X1,length);
  SetLength(Xh,length);
  SetLength(Lmd,length);
  For i:=0 to length-1 do
    Lmd[i]:=0;
  Fx:=FX12(Y[0][0],Y[0][1],true,delProg);
  Fxk:=Fx*1000;
  NomTest:=0;
  repeat

    {exit}
    if (Form1.RgMetod.ItemIndex=1) or ((Form1.RgMetod.ItemIndex=2) and ((Form1.ClbParamS.Checked[0]) or (Form1.RgMetodS.ItemIndex=2) and (not ExitAlg))) then
      Exit:=abs(Fx-Fxk)<eps
    else
    If (Form1.RgMetod.ItemIndex=2) and ((not Form1.ClbParamS.Checked[0]) or ((Form1.RgMetodS.ItemIndex=2) and (ExitAlg))) then
      begin
      if (BolShtraf) and (not BolKurs) then
        Exit:=Mu1*Ogr1<Eps
      else
      If (BolBarier) and (not BolKurs) then
        Exit:=Mu2*Ogr2<Eps
      else
      If BolKurs then
        Exit:=Mu1*Ogr1+Mu2*Ogr2<Eps;  
      end;

    If k>1500 then exit:=true;  

    if not Exit then begin
    If Form1.ClbParamS.Checked[4] then
      For i:=0 to Length-1 do
        Test[NomTest][i]:=Y[0][i];

    For j:=0 to Length-1 do
      begin
      If ((ParXykDhivs=0)and (Form1.RgMetod.ItemIndex=1)) or ((Form1.RgMetod.ItemIndex=2) and not (Form1.ClbParamS.Checked[1])) then
        begin
        Lmd[j]:=0;
        Znak:=1;
        F:=FX;
        FN;
        If F-FNext<0 then
          begin
          Znak:=-1;
          FN;
          end;
        While F-FNext>0 do
          begin
          Lmd[j]:=Lmd[j]+Znak*eps;
          F:=FNext;
          FN;
          end;
        end;
      If ((ParXykDhivs=1) and (Form1.RgMetod.ItemIndex=1)) or ((Form1.RgMetod.ItemIndex=2) and (Form1.ClbParamS.Checked[1]))then
        begin
        NLmd:=-ConstLmd;
        KLmd:=ConstLmd;
        Par:=j+1;
        Dihotomii(NLmd,KLmd,Eps,2.5*Eps,DelProg,False,kb);
        Lmd[j]:=NLmd+(KLmd-NLmd)/2;
        end;
      For i:=0 to length-1 do
        if I=j then
          Y[j+1][i]:=Y[j][i]+Lmd[j]
        else
         Y[j+1][i]:=Y[j][i];
      end;

    Str(FX12(Y[2][0],Y[2][1],false,0):10:6,st2);
    AddList(New,Y[0][0],Y[0][1],Y[1][0],Y[1][1],'',Form1.CbMu.Selected);
    AddList(New,Y[1][0],Y[1][1],Y[2][0],Y[2][1],'',Form1.CbMu.Selected);

    If not((BolShtraf) or (BolBarier) or (BolKurs)) then
      begin
      Str(Y[1][0]:4:3,st);
      Str(Y[1][1]:4:3,st1);
      Str(FX12(Y[1][0],Y[1][1],false,0):10:6,st2);
      Form1.StringGrid3.Cells[2,k]:='('+st+'; '+st1+')='+st2;
      Str(Y[2][0]:4:3,st);
      Str(Y[2][1]:4:3,st1);
      Str(FX12(Y[2][0],Y[2][1],false,0):10:6,st2);
      Form1.StringGrid3.Cells[3,k]:='('+st+'; '+st1+')='+st2;
      end;

    For i:=0 to length-1 do
      X1[i]:=Y[length][i];


    For i:=0 to length-1 do
      Xh[i]:=X1[i]-X0[i];
    If (ParXykDhivs=1) and (Form1.RgMetod.ItemIndex=1) or (Form1.RgMetod.ItemIndex=2)  then
      begin
      Par:=length+1;
      NLmd:=0;
      KLmd:=ConstLmd;
      Dihotomii(NLmd,KLmd,Eps,2.5*Eps,DelProg,False,kb);
      end
    else
    If ((ParXykDhivs=0)and (Form1.RgMetod.ItemIndex=1))then
      begin
      NLmd:=0;
      FNext:=FX12(Y[j][0]+(NLmd+Eps)*Xh[0],Y[j][1]+(NLmd+Eps)*Xh[1],true,delProg);
      While F>FNext do
        begin
        NLmd:=NLmd+eps;
        F:=FNext;
        FNext:=FX12(Y[j][0]+(NLmd+Eps)*Xh[0],Y[j][1]+(NLmd+Eps)*Xh[1],true,delProg);
        end;
      KLmd:=NLmd;
      end;
    {Проверка выхода за ограничения}  
    If Form1.ClbParamS.Checked[5] then
      begin
      NomInt:=0;
      repeat
        For i:=0 to length-1 do
        begin
          Case NomInt Of
            0:Y[0][i]:=X1[i]+Xh[i]*(NLmd+(KLmd-NLmd)/2);
            1:Y[0][i]:=X1[i]+Xh[i]*NLmd;
            2:Y[0][i]:=X1[i]+Xh[i]*KLmd;
            end;
          X0[i]:=X1[i];
        end;
        Fxk:=Fx;
        Fx:=FX12(Y[0][0],Y[0][1],true,delProg);
        Inc(NomInt);
      Until (Ogr1<=0) or (NomInt=3);
      end
    else
      begin
      For i:=0 to length-1 do
        begin
        Y[0][i]:=X1[i]+Xh[i]*(NLmd+(KLmd-NLmd)/2);
        X0[i]:=X1[i];
        end;
      Fxk:=Fx;
      Fx:=FX12(Y[0][0],Y[0][1],true,delProg);
      end;
    end;
    AddList(New,Y[2][0],Y[2][1],Y[0][0],Y[0][1],'',Form1.CbLa.Selected);

    {Уменьшение интервала неопределенности}
    If Form1.ClbParamS.Checked[4] then
      begin
      i:=0;
      repeat
        Inc(i);
      until (i=LengthTest-1) or ((abs(Y[0][0]-test[i][0])<2*eps) and (abs(Y[0][1]-test[i][1])<2*eps) and (i<>Nomtest));
      If i<>LengthTest-1 then
        ConstLmd:=ConstLmd/DecInt;
      Inc(Nomtest);
      If NomTest>LengthTest-1 then
        NomTest:=0;
      end;

    {Срез}
    If (Form1.CbSrez.Checked) and (k=StrToInt(Form1.LeIterSrez.Text)) then
      begin
      Setlength(YGr,Length+1);
      For i:=0 to length do
        SetLength(YGr[i],Length);
      SetLength(X1Gr,length);
      SetLength(XhGr,length);
      BolBarierGr:=BolBarier;
      BolShtrafGr:=BolShtraf;
      For i:=0 to length-1 do
        begin
        Xhgr[i]:=Xh[i];
        X1Gr[i]:=X1[i];
        YGr[0][i]:=Y[0][i];
        YGr[1][i]:=Y[1][i];
        end;
      end;

    If not((BolShtraf) or (BolBarier) or (BolKurs)) then
      begin
      Str(Y[0][0]:4:3,st);
      Str(Y[0][1]:4:3,st1);
      Str(FX:10:6,st2);
      Form1.StringGrid3.Cells[4,k]:='('+st+'; '+st1+')='+st2;
      end;

    If BolShtraf then
      Mu1:=Mu1*Bet1;
    if BolBarier then
      Mu2:=Mu2*bet2;
   If not((BolShtraf) or (BolBarier) or (BolKurs)) then
      begin
      If k<>1 then
        Form1.StringGrid3.RowCount:=K+1;
      Form1.StringGrid3.Cells[0,k]:=IntToStr(K);
      Str(Y[0][0]:4:3,st);
      Str(Y[0][1]:4:3,st1);
      Str(FX:10:6,st2);
      Form1.StringGrid3.Cells[1,k]:='('+st+'; '+st1+')='+st2;
      end
    else
      VivodBSK;
    inc(k);
  until exit;
  For i:=0 to length-1 do
    X0[i]:=Y[0][i];
  VivodBSK;
  addList(New,X0[0]+0.1,X0[1]+0.1,X0[0]-0.1,X0[1]-0.1,'Кон',clRed);
  addList(New,X0[0]-0.1,X0[1]+0.1,X0[0]+0.1,X0[1]-0.1,'',clRed);
  end;

Procedure VitGradX(var Gr:DinMas; length:word; Arg1,Arg2:real);
  var
  i:Word;
  begin
  For i:=0 to Length-1 do
    gr[i]:=LoadGrad(i+1,Arg1,Arg2);
  end;

Procedure NaiskorSpysk(eps:real; DelProg:Word; Grad:Boolean; var k:word);
  const
    ConstLmdGr = 1;
  var
    GradX,Xh1:DinMas;
    Nm,Nm1:real;
    NLmd,KLmd:real;
    Kb:Word;
    st,st1,st2:string;
    Cur,New:PObList;          {Списки}

  Function Norma(X:DinMas; length:word):real;
    var
    i:word; {счетчик}
    Rez:real;
    begin
    Rez:=0;
    For i:=0 to Length-1 do
      Rez:=Rez+X[i];
    Norma:=Sqrt(abs(Rez));
    end;

  begin
  Cur:=HeadList;
  While Cur.Next<>nil do
    Cur:=Cur.Next;
  If not GradSopr then
  If not grad then
    New:=PObList.Create(IntToStr(KolList)+'). Наискорейший спуск '+FloatToStr(X0[0])+' '+FloatToStr(X0[1]))
  else
    New:=PObList.Create(IntToStr(KolList)+'). Градиентный спуск '+FloatToStr(X0[0])+' '+FloatToStr(X0[1]))
  else
    New:=PObList.Create(IntToStr(KolList)+'). Градиентный сопряженный спуск '+FloatToStr(X0[0])+' '+FloatToStr(X0[1]));
  Cur.Next:=New;
  Inc(KolList);
  OptimGrad:=true;
  SetLength(GradX,2);
  SetLength(Xh,2);
  If GradSopr then
    SetLength(Xh1,2);
  repeat

    If k<>1 then
      Form1.StringGrid6.RowCount:=K+1;
    Form1.StringGrid6.Cells[0,k]:=IntToStr(K);
    Str(X0[0]:4:3,st);
    Str(X0[1]:4:3,st1);
    Str(FX12(X0[0],X0[1],false,0):10:6,st2);
    Form1.StringGrid6.Cells[1,k]:='('+st+'; '+st1+')='+st2;

    VitGradX(GradX,2,X0[0],X0[1]);
    If not grad then
      NM:=Norma(GradX,2);

    Str(GradX[0]:8:5,st);
    Str(GradX[1]:8:5,st1);
    If not grad then
      Str(NM:8:6,st2);
    Form1.StringGrid6.Cells[2,k]:='('+st+'; '+st1+')';
    If not grad then
      Form1.StringGrid6.Cells[4,k]:=st2;

    if (Nm>=eps) or (Grad) then
      begin
      If grad then
        begin
        Xh[0]:=-GradX[0];
        Xh[1]:=-GradX[1];
        end
      else
        If (not GradSopr) or (k=1) then
          begin
          Xh[0]:=-GradX[0]/Nm;
          Xh[1]:=-GradX[1]/Nm;
          end
        else
          begin
          Xh[0]:=-GradX[0]/Nm+sqr(Nm)/Sqr(Nm1)*Xh1[0];
          Xh[1]:=-GradX[1]/Nm+sqr(Nm)/Sqr(Nm1)*Xh1[1];
          end;
      Str(Xh[0]:8:5,st);
      Str(Xh[1]:8:5,st1);
      Form1.StringGrid6.Cells[3,k]:='('+st+'; '+st1+')';

      If GradSopr then
        begin  Xh1[0]:=Xh[0]; Xh1[1]:=Xh[1]; Nm1:=Nm end;
      NLmd:=0;
      KLmd:=ConstLmdGr;
      Dihotomii(NLmd,KLmd,Eps/1000,2.1*Eps/1000,DelProg,False,kb);

      AddList(New,X0[0],X0[1],X0[0]+(KLmd+NLmd)/2*Xh[0],X0[1]+(KLmd+NLmd)/2*Xh[1],'',Form1.CbMu.Selected);

      X0[0]:=X0[0]+(KLmd+NLmd)/2*Xh[0];
      X0[1]:=X0[1]+(KLmd+NLmd)/2*Xh[1];

      inc(k);
      end;
  Until ((Nm<Eps) and (not Grad)) or (((Grad) or (GradSopr)) and (abs(GradX[0])<eps) and (abs(GradX[1])<eps));
  OptimGrad:=false;
  end;

Procedure Ovrashnii(Lmd,Koef,eps:real; DelProg:Word; var k:word);
  var
    X0sp,X1sp:DinMas;
    F0sp,F1sp:real;
    j,nom:byte;
    Cur,New:PObList;          {Списки}

{  Procedure Spysk(Xn:DinMas; var Xk:DinMas; var F:Real);
    var
     Fnext:real;
     Znak:shortint;
     j:byte;
     Xc:DinMas;

    procedure Fn;
      begin
      if j=0 then
        FNext:=FX12(Xk[0]+Znak*Eps,Xk[1],true,delProg)
      else
        Fnext:=FX12(Xk[0],Xk[1]+Znak*Eps,true,delProg);
      end; {Fn}

{    begin  {Spysk}
{    SetLength(Xc,2);
    Xc[0]:=Xn[0]; Xc[1]:=Xn[1];
    SetLength(Xk,2);
    Xk[0]:=Xc[0]; Xk[1]:=Xc[1];
    repeat
      Xc[0]:=Xk[0]; Xc[1]:=Xk[1];
    For j:=0 to 1 do
      begin
      Znak:=1;
      F:=FX12(Xk[0],Xk[1],true,delProg);
      FN;
      If F-FNext<0 then
        begin
        Znak:=-1;
        FN;
        end;
      While F-FNext>0 do
        begin
        Xk[j]:=Xn[j]+Znak*eps;
        F:=FNext;
        FN;
        end;
      end;
    until Sqrt(Sqr(Xc[0]-Xk[0])+Sqr(Xc[1]-Xk[1]))<eps;
    end;
 }

 Procedure Spysk(Xn:DinMas; var Xk:DinMas; var F:Real); {Хук-Дживс, Наискорейший}
   var
   k:word;
   begin
     X0[0]:=Xn[0]; X0[1]:=Xn[1];
   {
     XykDhivs(2,eps,0,k);

     GradSopr:=true;
     k:=1;
     NaiskorSpysk(eps,0,False,k);

     GradSopr:=false;
   }
    NedlerMid(2,1,2,0.5,eps,0,k);
     Xk[0]:=X0[0]; Xk[1]:=X0[1];
     F:=FX12(Xk[0],Xk[1],false,0);
   end;


  var
  X0s,X1s,X2s:DinMas;
  st,st1,st2:string;

  begin
    Cur:=HeadList;
  While Cur.Next<>nil do
    Cur:=Cur.Next;
  New:=PObList.Create(IntToStr(KolList)+'). Овражный '+FloatToStr(X0[0])+' '+FloatToStr(X0[1]));
  Cur.Next:=New;
  Inc(KolList);
  SetLength(X0s,2); SetLength(X1s,2); SetLength(X2s,2);
  X0s[0]:=X0[0]; X1s[0]:=X1[0]; X0s[1]:=X0[1]; X1s[1]:=X1[1];

  SetLength(X1sp,2); SetLength(X0sp,2);
  Spysk(X1s,X1sp,F1sp);
  Spysk(X0s,X0sp,F0sp);
  AddList(New,X0[0],X0[1],X0sp[0],X0sp[1],'',Form1.CbLa.Selected);
  AddList(New,X1[0],X1[1],X1sp[0],X1sp[1],'',Form1.CbLa.Selected);
  repeat
  inc(k);
    For j:=0 to 1 do
      if F0sp<F1sp then
        begin
        X2s[j]:=X0sp[j]+Lmd*(X1sp[j]-X0sp[j]);
        If nom=1 then Lmd:=Lmd*Koef;
        nom:=0;
        end
      else
        begin
        X2s[j]:=X1sp[j]+Lmd*(X0sp[j]-X1sp[j]);
        If nom=0 then Lmd:=Lmd*Koef;
        nom:=1;
        end;

    If k<>1 then
      Form1.StringGrid3.RowCount:=K+1;
    Form1.StringGrid3.Cells[0,k]:=IntToStr(K);
    Str(X0sp[0]:10:8,st);
    Str(X0sp[1]:10:8,st1);
    Str(F0sp:12:8,st2);
    Form1.StringGrid3.Cells[1,k]:='('+st+'; '+st1+')='+st2;
    Str(X1sp[0]:10:8,st);
    Str(X1sp[1]:10:8,st1);
    Str(F1sp:12:8,st2);
    Form1.StringGrid3.Cells[2,k]:='('+st+'; '+st1+')='+st2;
    Str(X2s[0]:10:8,st);
    Str(X2s[1]:10:8,st1);
    Form1.StringGrid3.Cells[3,k]:='('+st+'; '+st1+')';
    {Спуск на новую точку}
    if nom=0 then
      begin
      AddList(New,X0sp[0],X0sp[1],X2[0],X2[1],'',Form1.CbMu.Selected);
      Spysk(X2s,X1sp,F1sp);
      Str(X1sp[0]:10:8,st);
      Str(X1sp[1]:10:8,st1);
      Str(F1sp:12:8,st2);
      Form1.StringGrid3.Cells[4,k]:='('+st+'; '+st1+')='+st2;
      AddList(New,X2[0],X2[1],X1sp[0],X1sp[1],'',Form1.CbLa.Selected);
      end
    else
      begin
      AddList(New,X1sp[0],X1sp[1],X2[0],X2[1],'',Form1.CbMu.Selected);
      Spysk(X2s,X0sp,F0sp);
      Str(X0sp[0]:10:8,st);
      Str(X0sp[1]:10:8,st1);
      Str(F0sp:12:8,st2);
      Form1.StringGrid3.Cells[4,k]:='('+st+'; '+st1+')='+st2;
      AddList(New,X2[0],X2[1],X0sp[0],X0sp[1],'',Form1.CbLa.Selected);
      end;
  until Sqrt(Sqr(X0sp[0]-X1sp[0])+Sqr(X0sp[1]-X1sp[1]))<eps; {Условие выхода}
  X0[0]:=X0sp[0]; X0[1]:=X0sp[1];  {Перезапись конечной точки}
  end;

end.
