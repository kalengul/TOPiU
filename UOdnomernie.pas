unit UOdnomernie;

interface

procedure Dihotomii(var A,B:real; Epsilon,L:real; DelFunc:word; vivod:boolean; var k:word);
procedure ZolotoeSetenie(var A,B:real; Epsilon,L,Alpha:real; DelFunc:word; vivod:boolean; var k:word);
procedure Fibonachi(var A,B:real; Epsilon,L:real; DelFunc:word; vivod:boolean; var k:word);

implementation

uses UForm,Graphics,SysUtils;

procedure Dihotomii(var A,B:real; Epsilon,L:real; DelFunc:word; vivod:boolean; var k:word);
var
FMu,FLa:real;
  Cur,New:PObList;
begin
If Vivod Then
  Begin
  TG:= StrToFloat (Form1.LET.Text);
  BG:= StrToFloat (Form1.LEB.Text);
  Cur:=HeadList;
  While Cur.Next<>nil do
    Cur:=Cur.Next;
  New:=PObList.Create(IntToStr(KolList)+'). ��������� '+FloatToStr(a)+' '+FloatToStr(b));
  Cur.Next:=New;
  Inc(KolList);
  k:=0;
  end;
repeat
  if B-A<=L then
    Break
  else
    begin
    k:=k+1;
    Lmbd:=0.5*(A+B)-Epsilon;
    Mu:=Lmbd+2*Epsilon;
    FLa:=fx(Lmbd,true,DelFunc);
    FMu:=fx(Mu,true,DelFunc);
    If Vivod Then
      Begin
      AddList(New,Lmbd,Tg,Lmbd,Bg,IntToStr(k),Form1.CbLa.Selected);
      AddList(New,mu,Tg,mu,Bg,IntToStr(k),Form1.CbMu.Selected);
      Form1.VivodIteracii;
      end;
    if FLa>FMu then
      A:=Lmbd
    else
      B:=Mu;
    end;
until false;
end;

procedure ZolotoeSetenie(var A,B:real; Epsilon,L,Alpha:real; DelFunc:word; vivod:boolean; var k:word);
var
FMu,FLa:real;
  Cur,New:PObList;
begin
If Vivod Then
  Begin
  TG:= StrToFloat (Form1.LET.Text);
  BG:= StrToFloat (Form1.LEB.Text);
  Cur:=HeadList;
  While Cur.Next<>nil do
    Cur:=Cur.Next;
  New:=PObList.Create(IntToStr(KolList)+'). ������� ������� '+FloatToStr(a)+' '+FloatToStr(b));
  Cur.Next:=New;
  Inc(KolList);
  end;
Lmbd:=A + (1-alpha)*(B-A);
Mu:=A + alpha*(B-A);
FLa:=fx(Lmbd,true,DelFunc);
FMu:=fx(Mu,true,DelFunc);
If Vivod Then
  Begin
  AddList(New,Lmbd,Tg,Lmbd,Bg,IntToStr(k),Form1.CbLa.Selected);
  AddList(New,mu,Tg,mu,Bg,IntToStr(k),Form1.CbMu.Selected);
  end;
repeat
  k:=k+1;
  If Vivod Then
    Form1.VivodIteracii;
  if FLa>FMu then
    begin
    A:=Lmbd;
    if B-A<=l then
      break;
    Lmbd:=Mu;
    Mu:=A + alpha*(B-A);
    FLa:=FMu;
    FMu:=fx(Mu,true,DelFunc);
    If Vivod Then
      AddList(New,mu,Tg,mu,Bg,IntToStr(k),Form1.CbMu.Selected);
    end
  else
    begin
    B:=Mu;
    if B-A<=l then
      break;
    Mu:=Lmbd;
    Lmbd:=A + (1-alpha)*(B-A);
    FMu:=FLa;
    FLa:=fx(Lmbd,true,DelFunc);
    If Vivod Then
      AddList(New,Lmbd,Tg,Lmbd,Bg,IntToStr(k),Form1.CbLa.Selected);
    end;
until false;
end;

procedure Fib (index: integer; var Fib_ind, Fib_pr: integer);
const
  F0=1;
  F1=1;
var
  i: integer;
  TFib_ind, TFib_pr, bufer: integer;
begin

  i:=1;
  if (index=1) then
    begin
      Fib_ind:=1;
      Fib_pr:=1;
      exit;
    end
  else
    begin
      TFib_ind:=1;
      TFib_pr:=1;

      repeat
        bufer:=TFib_ind;
        TFib_ind:=TFib_ind+TFib_pr;
        TFib_pr:=bufer;
        inc(i);
      until i=index;

    Fib_ind:=TFib_ind;
    Fib_pr:=TFib_pr;
    end;

end;

procedure Fibonachi(var A,B:real; Epsilon,L:real; DelFunc:word; vivod:boolean; var k:word);
var
FMu,FLa:real;
  n, sch: integer;
  Fn_k_1, Fn_k: integer;
  Cur,New:PObList;
begin
If Vivod Then
  Begin
  TG:= StrToFloat (Form1.LET.Text);
  BG:= StrToFloat (Form1.LEB.Text);
  Cur:=HeadList;
  While Cur.Next<>nil do
    Cur:=Cur.Next;
  New:=PObList.Create(IntToStr(KolList)+'). �������� '+FloatToStr(a)+' '+FloatToStr(b));
  Cur.Next:=New;
  Inc(KolList);
  end;
  sch:=1;
  repeat
    Fib(sch, Fn_k, Fn_k_1);
    inc(sch);
  until Fn_k>((B-A)/l);
  n:=sch;

  Fib(n-k, Fn_k, Fn_k_1);
  Lmbd:=A + (Fn_k_1/(Fn_k_1+Fn_k))*(B-A);
  Mu:=A + (Fn_k/(Fn_k_1+Fn_k))*(B-A);
  FLa:=fx(Lmbd,true,DelFunc);
  FMu:=fx(Mu,true,DelFunc);
  k:=1;
  If Vivod Then
    Begin
    AddList(New,Lmbd,Tg,Lmbd,Bg,IntToStr(k),Form1.CbLa.Selected);
    AddList(New,mu,Tg,mu,Bg,IntToStr(k),Form1.CbMu.Selected);
    end;

  repeat
    If Vivod Then
      Form1.VivodIteracii;
    if FLa>FMu then
      begin
      A:=Lmbd;
      Lmbd:=Mu;
      Mu:=A + (Fn_k_1/Fn_k)*(B-A);
      FLa:=FMu;
      FMu:=fx(Mu,true,DelFunc);
      If Vivod Then
        AddList(New,mu,Tg,mu,Bg,IntToStr(k),Form1.CbMu.Selected);
      end
    else
      begin
      B:=Mu;
      Mu:=Lmbd;
      Lmbd:=A + ((Fn_k-Fn_k_1)/Fn_k)*(B-A);
      FMu:=FLa;
      FLa:=fx(Lmbd,true,DelFunc);
      If Vivod Then
        AddList(New,Lmbd,Tg,Lmbd,Bg,IntToStr(k),Form1.CbLa.Selected);
      end;
    k:=k+1;
  until k=n-1;

  Mu:=Lmbd + Epsilon;
  If Vivod Then
    AddList(New,mu,Tg,mu,Bg,IntToStr(k),Form1.CbMu.Selected);
  FMu:=fx(Mu,true,DelFunc);
  If Vivod Then
    Form1.VivodIteracii;
  if FLa>FMu then
    A:=Lmbd
  else
    B:=Mu;
end;

end.
