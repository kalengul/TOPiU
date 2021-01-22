unit UForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Buttons,
  UOdnomernie,UMnogomernie, UFormula, CheckLst,UFormTabled;

type
  TForm1 = class(TForm)
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    StringGrid1: TStringGrid;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    RadioGroup1: TRadioGroup;
    LeKolFunct: TLabeledEdit;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    PBGrap: TPaintBox;
    CbFunctiono: TComboBox;
    Label1: TLabel;
    LEB: TLabeledEdit;
    LeT: TLabeledEdit;
    BtPaint: TButton;
    ClbPaint: TCheckListBox;
    CbMu: TColorBox;
    CbLa: TColorBox;
    RgMetod: TRadioGroup;
    CbFunctionN: TComboBox;
    LeX: TLabeledEdit;
    LeGam: TLabeledEdit;
    LeBet: TLabeledEdit;
    StringGrid2: TStringGrid;
    LePaint: TLabeledEdit;
    LePole: TLabeledEdit;
    LaMashtab: TLabel;
    BtTimer: TButton;
    ClbParam: TCheckListBox;
    RgMetodN: TRadioGroup;
    StringGrid3: TStringGrid;
    BtTabeled: TButton;
    RgXyDg: TRadioGroup;
    RgMetodS: TRadioGroup;
    CbFunctionS: TComboBox;
    LeOgran: TLabel;
    MeOgran: TMemo;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    ClbParamS: TCheckListBox;
    RgParamO: TRadioGroup;
    LeKolEpsilon: TLabeledEdit;
    LeShagEpsilon: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LeKolIter: TLabeledEdit;
    Label2: TLabel;
    MeKoordPole: TMemo;
    LeEpsGraph: TLabeledEdit;
    LeX1: TLabeledEdit;
    MeGrad: TMemo;
    LaGrad: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    StringGrid6: TStringGrid;
    LeDop: TLabeledEdit;
    LeLineOgr: TLabeledEdit;
    LeIterSrez: TLabeledEdit;
    CbSrez: TCheckBox;
    LePar: TLabeledEdit;
    LeP: TLabeledEdit;
    SgConstLamd: TStringGrid;
    LaConstLamd: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure VivodIteracii;
    procedure VivodKonO;
    procedure VivodKonN(X:DinMas);
    Procedure graphics;
    procedure BtPaintClick(Sender: TObject);
    procedure PBGrapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RgMetodClick(Sender: TObject);
    procedure BtTimerClick(Sender: TObject);
    procedure RgMetodNClick(Sender: TObject);
    procedure BtTabeledClick(Sender: TObject);
    procedure RgMetodSClick(Sender: TObject);
    procedure RgParamOClick(Sender: TObject);
    procedure ClbParamClick(Sender: TObject);
    procedure LePoleChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Str20 = string[20];
  PElList = ^ElList;
  ElList = record
           Color:TColor;
           Descriptor:Str20;
           xn,yn,xk,yk:real;
           next:PElList;
           end;
  PObList = class
            descriptor:String;
            Head,Current,Top:PElList;
            Next:PObList;
            Constructor Create(Desc:String);
            Destructor Destroy;
            end;

  Function fx (arg: real; IncKol:boolean; Del:word) : real;
  Function Fx12(arg1,arg2:real; IncKol:boolean; Del:word) :real;
  Function LoadGrad(Nom:word; Arg1,Arg2:real):Real;
  Procedure addList(List:PObList; xn,yn,xk,yk:real; descriptor:str20; Color:TColor);

var
  Form1: TForm1;
  Epsilon, l, a, b, Lmbd, Mu: real;
  k: word;
  KolFunction:word;
  LG,RG,TG,BG:real;
  HeadList:PObList;
  KolList:word;
  VivodGraphic:Boolean; {Вывод графика или Работа алгоритма}


Const
Shag=100;


implementation

Uses UFormTimer,UShtrBarCurs;

{$R *.dfm}
Procedure Delay(Value:cardinal);
  Var
  N:Cardinal;
  begin
  n:=0;
  While N<Value do
    begin
    Sleep(10);
    Inc(N);
    end;
  end;

Function RaspoznovanieO(st:string; arg:real; var FX:real):boolean;
  begin
  RaspoznovanieO:=true;
   if st='F(X)=(X+2)^3-Exp(X)' then fx:=-(arg+2)*(arg+2)*(arg+2)-exp(arg)
   else
     if st='F(X)=X^4-2*X^2+5' then fx:=Sqr(Sqr(Arg))-2*Sqr(arg)+5
   else
     RaspoznovanieO:=false;
  end;

Function RaspoznovanieN(st:string; arg1,arg2:real; var FX:real):boolean;
  begin
  RaspoznovanieN:=true;
  if st='F(X)=X1^2+X2^2' then fx:=sqr(arg1)+Sqr(arg2)
  else
    if st='F(X)=-X1^2-X2^2+X1*X2-X1+2*X2' then fx:=-sqr(arg1)-Sqr(arg2)+arg1*arg2-arg1+2*arg2
  else
    if st='F(X)=(X1-X2)^2+7*(X2^2-X1)^2' then fx:=sqr(arg1-arg2)+7*Sqr(Sqr(arg2)-arg1)
  else
    if st='F(X)=100*(X2-X1^2)^2+(1-X1)^2' then fx:=100*sqr(arg2-Sqr(arg1))+Sqr(1-arg1) {Функция Розенброка}
  else
    if st='F(X)=-X1^2-X2^2+10*X1+16*X2' then fx:=-Sqr(arg1)-Sqr(arg2)+10*arg1+16*arg2
  else
    if st='F(X)=50-5*X1^2-10*X2^2' then fx:=50-5*Sqr(arg1)-10*Sqr(arg2)
  else
    if st='F(X)<=X1+2*X2-21' then fx:=Arg1+2*arg2-21
  else
    if st='F(X)<=5*X1+2*X2-42' then fx:=5*Arg1+2*arg2-42
  else
    if st='F(X)<=X1+X2-2' then fx:=Arg1+arg2-2
  else
    if st='F(X)<=X1-X2+2' then fx:=Arg1-arg2+2
  else
    if st='F(X)<=(X1-1)^2+(X2+2)^2-12' then fx:=sqr(Arg1-1)+sqr(arg2+2)-12
  else
    if st='F(X)<=(X1-1)^2+X2-4' then fx:=sqr(Arg1-1)+arg2-4
  else
    if st='F(X)<=-X1-X2*5-90' then fx:=-Arg1-arg2*5-90
  else
    if st='F(X)<=X2-1' then fx:=Arg2-1
  else
    if st='F(X)<=-X1*2-X2' then fx:=-Arg1*2-arg2
  else
    if st='F(X)<=X1*2+X2' then fx:=Arg1*2+arg2    
  else
    if st='F(X)<=X1+2' then fx:=Arg1+2
  else
    if st='F(X)<=0.5-X1' then fx:=0.5-Arg1
  else
    if st='F(X)=X2' then fx:=Arg2    
  else
    if st='F(X)=2*X1' then fx:=2*Arg1
  else
    if st='F(X)=2*X2' then fx:=2*arg2
  else
    if st='F(X)=160*X1+1' then fx:=160*Arg1+1
  else
    if st='F(X)=0.8*X2+2' then fx:=0.8*arg2+2
  else
    if st='F(X)=80*X1^2+0.4*X2^2+X1+2*X2' then fx:=80*Sqr(Arg1)+0.4*Sqr(Arg2)+Arg1+2*Arg2
  else
    if st='F(X)=-6*X1-32*X2+X1^2+4*X2^2' then fx:=Sqr(Arg1)+4*Sqr(Arg2)-6*Arg1-32*Arg2
  else
    if st='F(X)=-6+2*X1' then fx:=-6+2*Arg1
  else
    if st='F(X)=-32+8*X2' then fx:=-32+8*Arg2
  else
  RaspoznovanieN:=false;
  end;


Function fx (arg: real; IncKol:boolean; Del:word) : real;
var
st:string;
f:real;
begin
fx:=0;
 {Стандартный вызов функции}
 If Form1.RgMetod.ItemIndex=0 then
   begin
   Delay(Del);
   st:=Form1.CbFunctiono.Text;
   if RaspoznovanieO(st,arg,F) then  fx:=F
   else
     begin
    delete(st,1,pos('=',st));
     fx:=FunctX(St,arg,0);
     end;
   end
 else
 {Круговая оптимизация использующая одномерные методы для двумерного анализа}
 If (Form1.RgMetod.ItemIndex=1) and (Form1.RgMetodN.ItemIndex=0) then
   begin
   If (Form1.ClbParam.Checked[0]) or (Form1.ClbParam.Checked[1]) then
     Fx:=Fx12(Cos(Arg/180*pi)*Xn3[0]-Sin(Arg/180*pi)*Xn3[1],Sin(Arg/180*pi)*Xn3[0]+Cos(Arg/180*pi)*Xn3[1],true,0);
   If Form1.ClbParam.Checked[2] then
     Fx:=Fx12(Xn2[0]+arg*(Xn3[0]-Xn2[0]),Xn2[1]+arg*(Xn3[1]-Xn2[1]),true,0);
   If Form1.ClbParam.Checked[3] then
     Fx:=Fx12(Xn2[0]+arg*(Xn3[0]-Xn2[0]),Xn2[1]+arg*(Xn3[1]-Xn2[1]),true,0);
   end
 else
 {Движение Хука-Дживса}
 If OptimGrad then
   begin
   Fx:=Fx12(X0[0]+Arg*Xh[0],X0[1]+Arg*Xh[1],true,0);
   end
 else
 If (((Form1.RgMetod.ItemIndex=2) or (Form1.RgMetodN.ItemIndex=1)) and (not VivOgr)) then
   begin
   if Par=1 then
     Fx:=Fx12(Y[0][0]+Arg,Y[0][1],true,0);
   if Par=2 then
     Fx:=Fx12(Y[1][0],Y[1][1]+Arg,true,0);
   if par=3 then
     Fx:=Fx12(X1[0]+Arg*Xh[0],X1[1]+Arg*Xh[1],true,0);
   end;
 if IncKol then
   Inc(KolFunction);
end;

{Функция вычисления степени}
Function Stepen(Arg:real; p:word):real;
  var
  i:word;
  Rez:real;
  begin
  Rez:=1;
  For i:=1 to p do
    Rez:=Rez*Arg;
  Stepen:=Rez;
  end;

{Функция для вычисления значени двумерной функции}
Function Fx12(arg1,arg2:real; IncKol:boolean; Del:word) :real;
var
st:string;
f,Ogr,Funct:real;
i:word;
Ch:char;
begin
Fx12:=0;
{Стандартный вызов двумерной функции}
if ((Form1.RgMetod.ItemIndex=1) or (VivodGraphic)) and (not VivOgr)  then
  begin
  If Form1.RgMetod.ItemIndex=1 then
    st:=Form1.CbFunctionN.Text
  else
    st:=Form1.CbFunctionS.Text;
  if RaspoznovanieN(st,arg1,arg2,F) then  fx12:=F
  else
    begin
    delete(st,1,pos('=',st));
    fx12:=FunctX(St,arg1,arg2);
    end;
  end
else
{Стандартный вызов функции ограничений по номеру ограничения NOgr}
if (Form1.RgMetod.ItemIndex=2) and (VivOgr) then
   begin
   st:=Form1.MeOgran.Lines.Strings[NOgr];
  if RaspoznovanieN(st,arg1,arg2,F) then  fx12:=F
  else
    begin
    delete(st,1,pos('=',st));
    fx12:=FunctX(St,arg1,arg2);
    end;
   end
else
{Распознание функции, ограничений и формирование Штрафной или Барьерной функции}
if (Form1.RgMetod.ItemIndex=2) then
  begin
  {Распознование функции}
  St:=Form1.CbFunctionS.Text;
  if not RaspoznovanieN(st,arg1,arg2,Funct) then
    begin
    delete(st,1,pos('=',st));
    Funct:=FunctX(St,arg1,arg2);
    end;
 {Распознование ограничений}
  Ogr1:=0; Ogr2:=0;

  For i:=0 to Form1.MeOgran.Lines.Count-1 do
    begin
    St:=Form1.MeOgran.Lines[i];
    ch:=st[5];
    if RaspoznovanieN(st,arg1,arg2,F) then
      begin
        If (BolShtraf) and (F>0) or (ch='=') then
           if ((abs(F)>1) and ((Form1.ClbParamS.Checked[2]) or (SpyskBol))) or (not Form1.ClbParamS.Checked[2]) then
            If Form1.ClbParamS.Checked[3] then
             Ogr1:=ogr1+Stepen(F+1,P)
            else
             Ogr1:=ogr1+Stepen(F,P)
          else
            If Form1.ClbParamS.Checked[3] then
              Ogr1:=ogr1+Stepen(F+1,P)
            else
              Ogr1:=ogr1+abs(F);
        If (BolBarier) and (Ch<>'=') AND (F<0)then
          If Form1.ClbParamS.Checked[7] then
            Ogr2:=Ogr2+Stepen(1/F,P)
          else
            Ogr2:=Ogr2-1/F;
      end
    else
      If not ((ch='=') and (BolBarier) and (not BolShtraf))and (not RaspoznovanieN(st,arg1,arg2,Ogr)) then
        begin
        If ch='<' then
          delete(st,1,pos('=',st));
        If ch='=' then
          delete(st,1,pos('=',st));
       {Учет ограничений}
        ogr:=FunctX(St,arg1,arg2);
        If ((BolShtraf) and ((ch='=') or ((ch='<') and (Ogr>0)))) then
          if ((abs(Ogr)>1) and ((Form1.ClbParamS.Checked[2]) or (SpyskBol))) or (not Form1.ClbParamS.Checked[2]) then
            If Form1.ClbParamS.Checked[3] then
              Ogr1:=ogr1+Stepen(Ogr+1,P)
            else
              Ogr1:=ogr1+Stepen(Ogr,P)
          else
            If Form1.ClbParamS.Checked[3] then
              Ogr1:=ogr1+Stepen(Ogr+1,P)
            else
            Ogr1:=ogr1+abs(Ogr);
        If (BolBarier) and (Ch<>'=') then
          Ogr2:=Ogr2-1/ogr;
        end;
    end;
 {формирование Штрафной функции}
  If BolShtraf then
    Funct:=Funct+Mu1*Ogr1;
 {Формирование Барьерной функции}
  If BolBarier then
    Funct:=Funct+Mu2*Ogr2;
  Fx12:=Funct;
  end;
 if IncKol then
 Inc(KolFunction);
end;

{Вычисление градиента в точке}
Function LoadGrad(Nom:word; Arg1,Arg2:real):Real;
  var
  st:string;
  Funct:real;
  begin
  st:=Form1.MeGrad.Lines.Strings[Nom-1];
  if not RaspoznovanieN(st,arg1,arg2,Funct) then
    begin
    delete(st,1,pos('=',st));
    Funct:=FunctX(St,arg1,arg2);
    end;
  LoadGrad:=Funct;
  end;
{
procedure Clear(StringGrid1:TStringGrid; raw_number: integer);
var
i:word;
begin
  For i:=0 to StringGrid1.ColCount do
    if (i<>1) and (i<>2) then
      StringGrid1.Cells[i,raw_number]:='';
end;
}
procedure TForm1.FormCreate(Sender: TObject);
var i:byte;
    CurList:pObList;
begin
  OptimGrad:=false;
  VivOgr:=false;
  k:=0;
  StringGrid1.ColWidths[0]:=20;
  StringGrid2.ColWidths[0]:=20;
  StringGrid3.ColWidths[0]:=20;
  StringGrid4.ColWidths[0]:=20;
  StringGrid5.ColWidths[0]:=20;
  StringGrid6.ColWidths[0]:=20;

  StringGrid1.Cells[0,0]:='K';
  StringGrid1.Cells[1,0]:='Ak';
  StringGrid1.Cells[2,0]:='Bk';
  StringGrid1.Cells[3,0]:='Lmbd_k';
  StringGrid1.Cells[4,0]:='Mu_k';
  StringGrid1.Cells[5,0]:='F(Lmbd_k)';
  StringGrid1.Cells[6,0]:='F(Mu_k)';
  StringGrid1.Cells[0,1]:='1';

  StringGrid2.Cells[0,0]:='K';
  StringGrid2.Cells[1,0]:='(X0; Y0)=F0';
  StringGrid2.Cells[2,0]:='(X1; Y1)=F1';
  StringGrid2.Cells[3,0]:='(X2; Y2)=F2';
  StringGrid2.Cells[4,0]:='(Xh; Yh)';
  StringGrid2.Cells[5,0]:='(XL; YL)';
  StringGrid2.Cells[6,0]:='(Xn2; Yn2)=Fn2';
  StringGrid2.Cells[7,0]:='(Xn3; Yn3)=Fn3';
  StringGrid2.Cells[8,0]:='(Xn4; Yn4)=Fn4';
  StringGrid2.Cells[9,0]:='(Xn5; Yn5)=Fn5';
  StringGrid2.Cells[0,1]:='1';

  StringGrid3.Cells[0,0]:='K';
  StringGrid3.Cells[1,0]:='(X0; Y0)=F0';
  StringGrid3.Cells[2,0]:='(X1; Y1)=F1';
  StringGrid3.Cells[3,0]:='(X2; Y2)=F2';
  StringGrid3.Cells[4,0]:='(X3; Y3)=F3';
  StringGrid3.Cells[0,1]:='1';

  StringGrid4.Cells[0,0]:='K';
  StringGrid4.Cells[1,0]:='(X; Y)=F';
  StringGrid4.Cells[2,0]:='Mu';
  StringGrid4.Cells[3,0]:='Mu*OgrS(OgrB)';
  StringGrid4.Cells[4,0]:='F+Mu*OgrS(OgrB)';
  StringGrid4.Cells[0,1]:='1';

  StringGrid5.Cells[0,0]:='K';
  StringGrid5.Cells[1,0]:='(X; Y)=F';
  StringGrid5.Cells[2,0]:='Mu1';
  StringGrid5.Cells[3,0]:='Mu1*OgrS';
  StringGrid5.Cells[4,0]:='Mu2';
  StringGrid5.Cells[5,0]:='Mu2*OgrB';
  StringGrid5.Cells[6,0]:='F+Mu1*OgrS+Mu2*OgrB';
  StringGrid5.Cells[0,1]:='1';

  StringGrid6.Cells[0,0]:='K';
  StringGrid6.Cells[1,0]:='(X0; Y0)=F0';
  StringGrid6.Cells[2,0]:='Grad(X0; Y0)';
  StringGrid6.Cells[3,0]:='(Xh; Yh)';
  StringGrid6.Cells[4,0]:='Norma';
  StringGrid6.Cells[0,1]:='1';

  For i:=1 to 4 do
    StringGrid6.ColWidths[i]:=150;

  For i:=1 to 6 do
    StringGrid5.ColWidths[i]:=150;
  StringGrid5.ColWidths[2]:=70;
  StringGrid5.ColWidths[4]:=70;

  For i:=1 to 4 do
    StringGrid4.ColWidths[i]:=150;
  StringGrid4.ColWidths[2]:=60;

  For i:=1 to 4 do
    StringGrid3.ColWidths[i]:=150;

  For i:=1 to 9 do
    StringGrid2.ColWidths[i]:=150;
  StringGrid2.ColWidths[4]:=80;
  StringGrid2.ColWidths[5]:=80;

  For i:=1 to 6 do
    StringGrid1.ColWidths[i]:=100;

  HeadList:=pObList.Create('Оси');
  Curlist:=pObList.Create('Оптимум');
  HeadList.Next:=CurList;
  KolList:=0;
  For i:=0 to 2 do
    SgConstLamd.Cells[0,i]:='10';
end;

procedure TForm1.VivodIteracii;
var st:string;
begin
  StringGrid1.RowCount:=K+1;
  Str(K:3,st);
  StringGrid1.Cells[0,k]:=st;
  Str(A:10:8,st);
  StringGrid1.Cells[1,k]:=st;
  Str(B:10:8,st);
  StringGrid1.Cells[2,k]:=st;
  Str(Lmbd:10:8,st);
  StringGrid1.Cells[3,k]:=st;
  Str(Mu:10:8,st);
  StringGrid1.Cells[4,k]:=st;
  Str(fx(Lmbd,false,0):10:8,st);
  StringGrid1.Cells[5,k]:=st;
  Str(fx(Mu,false,0):10:8,st);
  StringGrid1.Cells[6,k]:=st;
end;

procedure TForm1.VivodKonO;
var st:string;
begin
 StringGrid1.RowCount:=StringGrid1.RowCount+1;
 Str(A:10:8,st);
 StringGrid1.Cells[1,StringGrid1.RowCount-1]:=st;
 Str(B:10:8,st);
 StringGrid1.Cells[2,StringGrid1.RowCount-1]:=st;
 Str((A+B)/2:10:8,st);
 LabeledEdit5.Text:= st;
 Str(fx((A+B)/2,false,0):10:8,st);
 LabeledEdit6.Text:= st;
 LeKolFunct.Text:=IntToStr(KolFunction);
 LeKolIter.Text:=IntToStr(k);
end;

procedure TForm1.VivodKonN(X:DinMas);
var st,st1,st2:string;
begin
  StringGrid2.RowCount:=StringGrid2.RowCount+1;
  Str(X0[0]:4:3,st);
  Str(X0[1]:4:3,st1);
  Str(F0:4:3,st2);
  StringGrid2.Cells[1,StringGrid2.RowCount-1]:='('+st+'; '+st1+')='+st2;
  If (RgMetodN.ItemIndex=0) and (RgMetod.ItemIndex=1) then
    begin
    Str(X1[0]:4:3,st);
    Str(X1[1]:4:3,st1);
    Str(F1:4:3,st2);
    StringGrid2.Cells[2,StringGrid2.RowCount-1]:='('+st+'; '+st1+')='+st2;
    Str(X2[0]:4:3,st);
    Str(X2[1]:4:3,st1);
    Str(F2:4:3,st2);
    StringGrid2.Cells[3,StringGrid2.RowCount-1]:='('+st+'; '+st1+')='+st2;
    end;
  Str(X[0]:10:8,st);
  Str(X[1]:10:8,st1);
  LabeledEdit5.Text:='('+st+'; '+st1+')';
  Str(FX12(X[0],X[1],false,0):10:8,st);
  LabeledEdit6.Text:=st;
  LeKolFunct.Text:=IntToStr(KolFunction);
  LeKolIter.Text:=IntToStr(k);
end;



Procedure ClearTabled(SG:TStringGrid);
  var
  i,j:word;
  begin
  For i:=0 to Sg.ColCount do
    For j:=1 to Sg.RowCount do
      Sg.Cells[i,j]:='';
  Sg.RowCount:=2;
  end;

procedure TForm1.Button2Click(Sender: TObject);
const
  alpha=0.618;
var
  Gam,Bet,alf:real;
  i:byte;
  st:string;
  zz:integer;
begin
  TG:= StrToFloat (LET.Text);
  BG:= StrToFloat (LEB.Text);
  KolFunction:=0;  
  if RgMetod.ItemIndex=0 then
  begin
  ClearTabled(StringGrid1);
  StringGrid1.RowCount:=2;
  StringGrid1.Enabled:=true;
  k:=0;
  Epsilon:=StrToFloat (LabeledEdit1.Text);
  L:= StrToFloat (LabeledEdit2.Text);
  A:= StrToFloat (LabeledEdit3.Text);
  B:= StrToFloat (LabeledEdit4.Text);
  if RadioGroup1.ItemIndex=0 then
    begin
    if L<2*Epsilon then
      begin
      ShowMessage('Алгоритм зациклился');
      exit;
      end;
     if (RgParamO.ItemIndex=0) or (RgMetod.ItemIndex<>0) then
       Dihotomii(A,B,Epsilon,L,0,true,k)
     else
       For i:=1 to StrToInt(LeKolEpsilon.text) do
          begin
          Epsilon:=Epsilon/StrToFloat(LeShagEpsilon.Text);
          L:=L/StrToFloat(LeShagEpsilon.Text);
          Dihotomii(A,B,Epsilon,L,0,true,k)
          end;
     addList(HeadList.Next,(A+B)/2,tg,(A+B)/2,bg,'Дихотомии',clBlue);
     end;
   if RadioGroup1.ItemIndex=1 then
     begin
     if (RgParamO.ItemIndex=0) or (RgMetod.ItemIndex<>0) then
       ZolotoeSetenie(A,B,Epsilon,L,Alpha,0,true,k)
     else
       For i:=1 to StrToInt(LeKolEpsilon.text) do
          begin
          Epsilon:=Epsilon/StrToFloat(LeShagEpsilon.Text);
          L:=L/StrToFloat(LeShagEpsilon.Text);
          ZolotoeSetenie(A,B,Epsilon,L,Alpha,0,true,k)
          end;
     addList(HeadList.Next,(A+B)/2,tg,(A+B)/2,bg,'Зол сечение',clGreen);
     end;
    if RadioGroup1.ItemIndex=2 then
     begin
     if (RgParamO.ItemIndex=0) or (RgMetod.ItemIndex<>0) then
       Fibonachi(A,B,Epsilon,L,0,true,k)
     else
       For i:=1 to StrToInt(LeKolEpsilon.text) do
          begin
          Epsilon:=Epsilon/StrToFloat(LeShagEpsilon.Text);
          L:=L/StrToFloat(LeShagEpsilon.Text);
          Fibonachi(A,B,Epsilon,L,0,true,k);
          end;
     addList(HeadList.Next,(A+B)/2,tg,(A+B)/2,bg,'Фибоначи',clRed);
     end;
   VivodKonO;
   end;
 if RgMetod.ItemIndex=1 then
   begin
   ClearTabled(StringGrid2);
   ClearTabled(StringGrid3);
   Epsilon:=StrToFloat (LabeledEdit1.Text);
   SetLength(X0,2);
   st:=LeX.Text;
   Val (Copy(St,2,Pos(';',st)-2),X0[0],zz);
   Val (Copy(St,Pos(';',st)+1,Pos(')',st)-(Pos(';',st)+1)),X0[1],zz);
   Case RgMetodN.ItemIndex of
   0:begin
     addList(HeadList.Next,X0[0]+0.1,X0[1]+0.1,X0[0]-0.1,X0[1]-0.1,'Нач',clRed);
     addList(HeadList.Next,X0[0]-0.1,X0[1]+0.1,X0[0]+0.1,X0[1]-0.1,'',clRed);
     k:=0;
     Gam:= StrToFloat (LeGam.Text);
     Bet:= StrToFloat (LeBet.Text);
     Alf:=StrTofloat (LabeledEdit2.Text);
     a:= StrToFloat (LeDop.Text);
     NedlerMid(2,alf,gam,bet,epsilon,0,k);
     VivodKonN(X0);
     addList(HeadList.Next,X0[0]+0.1,X0[1]+0.1,X0[0]-0.1,X0[1]-0.1,'Кон',clRed);
     addList(HeadList.Next,X0[0]-0.1,X0[1]+0.1,X0[0]+0.1,X0[1]-0.1,'',clRed);
     end;
   1:begin
     k:=0;
     For i:=1 to 4 do
       StringGrid3.ColWidths[i]:=150;
     ParXykDhivs:=RgXyDg.ItemIndex;
     XykDhivs(2,epsilon,0,k);
     VivodKonN(X0);
     end;
   2:begin
     k:=0;
     For i:=1 to 4 do
       StringGrid3.ColWidths[i]:=250;
     SetLength(X1,2);
     st:=LeX1.Text;
     Val (Copy(St,2,Pos(';',st)-2),X1[0],zz);
     Val (Copy(St,Pos(';',st)+1,Pos(')',st)-(Pos(';',st)+1)),X1[1],zz);
     Gam:= StrToFloat (LeGam.Text);
     Alf:=StrTofloat (LabeledEdit2.Text);
     Ovrashnii(gam,Alf,epsilon,0,k);
     VivodKonN(X0);
     end;
   3:Begin
     k:=1;
     NaiskorSpysk(epsilon,0,False,k);
     VivodKonN(X0);
     end;
   4:Begin
     k:=1;
     NaiskorSpysk(epsilon,0,True,k);
     VivodKonN(X0);
     end;
   5:begin
     k:=1;
     GradSopr:=true;
     NaiskorSpysk(epsilon,0,False,k);
     GradSopr:=false;
     VivodKonN(X0);
     end;
   end;
   end;
 if RgMetod.ItemIndex=2 then
   begin
   k:=0;
   ClearTabled(StringGrid4);
   ClearTabled(StringGrid5);
   BolShtraf:=false;
   BolBarier:=false;
   SetLength(X0,2);
   st:=LeX.Text;
   Val (Copy(St,2,Pos(';',st)-2),X0[0],zz);
   Val (Copy(St,Pos(';',st)+1,Pos(')',st)-(Pos(';',st)+1)),X0[1],zz);
   Case RgMetodS.ItemIndex of
     0:Shtraf(k);
     1:Barier(k);
     2:Cursach(k);
     end;
   VivodKonN(X0);
     addList(HeadList.Next,X0[0]+0.1,X0[1]+0.1,X0[0]-0.1,X0[1]-0.1,'Кон',clRed);
     addList(HeadList.Next,X0[0]-0.1,X0[1]+0.1,X0[0]+0.1,X0[1]-0.1,'',clRed);
   end;
end;

procedure TForm1.BtPaintClick(Sender: TObject);
var
i:Real;
begin
  LG:= StrToFloat (LabeledEdit3.Text);
  RG:= StrToFloat (LabeledEdit4.Text);
  TG:= StrToFloat (LET.Text);
  BG:= StrToFloat (LEB.Text);
  i:=trunc(Lg);
  While I<=trunc(Rg) do
    begin
    AddList(HeadList,i,TG,i,Bg,IntTostr(Trunc(i)),ClBlack);
    i:=i+trunc(Rg-Lg) div StrToInt(LePaint.text)+1;
    end;
  i:=trunc(Bg);
  While I<=trunc(Tg) do
    begin
    AddList(HeadList,Rg,i,Lg,i,IntTostr(Trunc(i)),ClBlack);
    i:=i+trunc(Tg-Bg) div StrToInt(LePaint.text)+1;
    end;
  graphics;
end;

Procedure TForm1.graphics;
var
  Mx,My:real;
  X,Yv,Z:Real;
  Znat:real;
  i,j,nom,kol,NomOgr:LongInt;
  Current:PObList;
  bol:boolean;
  EpsGrap:real;
  zz:integer;
  LineOgr:real;
begin
  PatBlt(PbGrap.Canvas.Handle, 0, 0, PbGrap.ClientWidth, PbGrap.ClientHeight, WHITENESS);
  Mx:=(RG-LG)/(PBGrap.Width-20);
  My:=(TG-BG)/(PBGrap.Height-20);
  PbGrap.Canvas.Pen.Color:=clBlack;
  if (RgMetod.ItemIndex=0) or (CbSrez.Checked) then
  begin
    if (CbSrez.Checked) then
      begin
      Par:=StrToInt(LePar.Text);
      BolBarier:=BolBarierGr;
      BolShtraf:=BolShtrafGr;
      For i:=0 to 1 do
        begin
        Xh[i]:=XhGr[i];
        X1[i]:=X1Gr[i];
        Y[0][i]:=YGr[0][i];
        Y[1][i]:=YGr[1][i];
        end;
      end;
  nom:=1;
  PbGrap.Canvas.Pen.Color:=clBlack;
  repeat
  For i:=10 to PBGrap.Width-10 do
    begin
    X:=Mx*i+LG;
    Yv:=Fx(X,False,0);
    j:=PBGrap.Height-10-trunc((Yv-BG)/My);
    if i=10 then
      PbGrap.Canvas.MoveTo(i,j)
    else
      PbGrap.Canvas.LineTo(i,j);
    end;
    inc(nom);
    BolBarier:=false;
    BolShtraf:=false;
    PbGrap.Canvas.Pen.Color:=clred;
  until not (CbSrez.Checked) or (CbSrez.Checked) and (nom=3)
    end
  else
  if RgMetod.ItemIndex=1 then
    begin
    Kol:=StrToInt (LePole.Text);
    EpsGrap:=StrToFloat(LeEpsGraph.text);
    For Nom:=1 to kol do
    begin
    Znat:=StrToInt(MeKoordPole.Lines.Strings[Nom-1]);
    For i:=10 to PBGrap.Width-10 do
      For j:=10 to PBGrap.Height-10 do
        begin
        X:=Mx*i+LG;
        Yv:=(PBGrap.Height-j)*My+Bg;
        Z:=Fx12(X,Yv,False,0);
        If abs(Z-Znat)<EpsGrap then
          PbGrap.Canvas.Pixels[i,j]:=ClBlack;
        end;
     end;
     end
  else
  if RgMetod.ItemIndex=2 then
    begin
    VivodGraphic:=True;
    Kol:=StrToInt (LePole.Text);
    EpsGrap:=StrToFloat(LeEpsGraph.text);
    LineOgr:=strtoFloat(LeLineOgr.Text);
    For Nom:=1 to kol do
    begin
    Znat:=StrToFloat(MeKoordPole.Lines.Strings[Nom-1]);
    For i:=10 to PBGrap.Width-10 do
      For j:=10 to PBGrap.Height-10 do
        begin
        X:=Mx*i+LG;
        Yv:=(PBGrap.Height-j)*My+Bg;
        Z:=Fx12(X,Yv,False,0);
        If abs(Z-Znat)<EpsGrap then
          PbGrap.Canvas.Pixels[i,j]:=ClBlack;
        end;
     end;
     VivOgr:=true;
     For nomOgr:=0 to MeOgran.Lines.Count-1 do
{     if ((RgMetodS.ItemIndex=1) and (Pos('<',MeOgran.Lines.Strings[Nom])<>0)) or (RgMetodS.ItemIndex=0) or (RgMetodS.ItemIndex=2) then}
     begin
     NOgr:=nomOgr;
     For i:=10 to PBGrap.Width-10 do
       For j:=10 to PBGrap.Height-10 do
         begin
         X:=Mx*i+LG;
         Yv:=(PBGrap.Height-j)*My+Bg;
         Z:=Fx12(X,Yv,False,0);
         If abs(Z-0)<LineOgr then
           begin
           Case NOgr of
             0:PbGrap.Canvas.Pixels[i,j]:=ClRed;
             1:PbGrap.Canvas.Pixels[i,j]:=ClBlue;
             2:PbGrap.Canvas.Pixels[i,j]:=ClGreen;
             3:PbGrap.Canvas.Pixels[i,j]:=ClGray;
             4:PbGrap.Canvas.Pixels[i,j]:=ClAqua;
             else
               PbGrap.Canvas.Pixels[i,j]:=ClYellow;
             end;
           end;
         end;
     end;
     VivOgr:=false;
     VivodGraphic:=False;
     end;
  Current:=HeadList;
  While Current<>nil do
    begin
    Bol:=false;
    For i:=0 to ClbPaint.Items.Count-1 do
      If (ClbPaint.Checked[i]) and (ClbPaint.Items.Strings[i]=Current.descriptor) then
        begin
        Bol:=true;
        break;
        end;
    If Bol then
    Current.Current:=Current.Head;
    While Current.Current<>nil do
      begin
      PbGrap.Canvas.Pen.Color:=Current.Current.Color;
      PbGrap.Canvas.MoveTo(trunc((Current.Current.Xn-LG)/Mx),PBGrap.Height-10-Trunc((Current.Current.Yn-Bg)/My));
      PbGrap.Canvas.LineTo(trunc((Current.Current.Xk-LG)/Mx),PBGrap.Height-10-Trunc((Current.Current.Yk-Bg)/My));
      PbGrap.Canvas.Brush.Color:=ClWhite;
      if PBGrap.Height-10-Trunc((Current.Current.Yk-Bg)/My)>PBGrap.Height then
        PbGrap.Canvas.TextOut(trunc((Current.Current.Xk-LG)/Mx),PBGrap.Height-10,Current.Current.Descriptor)
      else
      If trunc((Current.Current.Xk-LG)/Mx)<0  then
        PbGrap.Canvas.TextOut(0,PBGrap.Height-10-Trunc((Current.Current.Yk-Bg)/My),Current.Current.Descriptor)
      else
      PbGrap.Canvas.TextOut(trunc((Current.Current.Xk-LG)/Mx),PBGrap.Height-10-Trunc((Current.Current.Yk-Bg)/My),Current.Current.Descriptor);
      Current.Current:=Current.Current.next;
      end;
    Current:=Current.Next;
    end;
end;

procedure TForm1.PBGrapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Dx,Dy,Mx,My:real;
  st:string;
begin
  Dx:=Rg-Lg;
  Dy:=Tg-Bg;
  Mx:=(RG-LG)/(PBGrap.Width-20);
  My:=(TG-BG)/(PBGrap.Height-20);
  Dx:=Dx-Shag*Mx;
  Dy:=Dy-Shag*My;
    Str(Dx:6:4,st);
    LaMashtab.Caption:='Маштаб - '+st+'X ';
    Str(Dy:6:4,st);
    LaMashtab.Caption:=LaMashtab.Caption+st+'Y';
  Rg:=(X*Mx+Lg)+Dx/2;
  Lg:=(X*Mx+Lg)-Dx/2;
  Tg:=((PBGrap.Height-Y)*My+Bg)+Dy/2;
  Bg:=((PBGrap.Height-Y)*My+Bg)-Dy/2;
  graphics;
end;

Constructor PObList.Create(Desc:String);
  begin
  Descriptor:=Desc;
  Head:=nil;
  Current:=nil;
  Top:=nil;
  Next:=nil;
  Form1.CLbPaint.Items.Add(Descriptor);
  end;

Destructor PObList.Destroy;
  var
  del:PelList;
  begin
  Current:=Head;
  While Current<>nil do
    begin
    Del:=Current;
    Current:=Current.next;
    del.next:=nil;
    Dispose(del);
    end;
  Current:=nil;
  Head:=nil;
  Top:=nil;
  Next:=nil;
  end;

Procedure addList(List:PObList; xn,yn,xk,yk:real; Descriptor:str20; Color:tColor);
  var
    NewList:PElList;
  begin
  New(NewList);
  NewList.xn:=xn;
  NewList.yn:=yn;
  NewList.xk:=xk;
  NewList.yk:=yk;
  NewList.Descriptor:=Descriptor;
  NewList.Color:=Color;
  NewList.next:=nil;
  If List.head=nil then
    List.Head:=NewList
  else
    List.Top.Next:=NewList;
  List.Top:=NewList;
  end;

procedure TForm1.RgMetodClick(Sender: TObject);
begin
  Case RgMetod.ItemIndex of
    0:begin
      RadioGroup1.Visible:=true; RgMetodN.Visible:=false; RgMetodS.Visible:=false;
      CbFunctionO.Visible:=true; CbFunctionN.Visible:=false; CbFunctionS.Visible:=false;
      StringGrid1.Visible:=true; Stringgrid2.Visible:=false; StringGrid3.Visible:=false; StringGrid4.Visible:=false; StringGrid5.Visible:=False; StringGrid6.Visible:=False;
      LabeledEdit3.EditLabel.Caption:='A1';
      LabeledEdit4.EditLabel.Caption:='B1';
      LabeledEdit2.EditLabel.Caption:='L';
      LabeledEdit2.EditLabel.Visible:=true;
      RgParamO.Visible:=true; LeKolEpsilon.Visible:=false; LeShagEpsilon.Visible:=false;
      LeOgran.Visible:=false;
      MeOgran.Visible:=false;
      LeGam.Visible:=false; LeBet.Visible:=false; LeX.Visible:=false;
      LePole.Visible:=false;
      ClbParam.Visible:=false;
      RgXyDg.Visible:=false;
      ClbParams.Visible:=false;
      MeKoordPole.Visible:=false;LeDop.Visible:=false;
      LeEpsGraph.Visible:=false;   LeP.Visible:=false;
      LeX1.Visible:=false;
      meGrad.Visible:=false;LaGrad.Visible:=false;
      LePar.Visible:=false;  LeIterSrez.Visible:=false;  CbSrez.Visible:=false;
      SgConstLamd.Visible:=false; LaConstLamd.Visible:=false;
      end;
    1:begin
      RadioGroup1.Visible:=False; RgMetodN.Visible:=true; RgMetodS.Visible:=false;
      CbFunctionO.Visible:=False; CbFunctionN.Visible:=true; CbFunctionS.Visible:=false;
      StringGrid1.Visible:=False; Stringgrid2.Visible:=true; StringGrid3.Visible:=false; StringGrid4.Visible:=false; StringGrid5.Visible:=False;StringGrid6.Visible:=False;
      LabeledEdit3.EditLabel.Caption:='Left';
      LabeledEdit4.EditLabel.Caption:='Right';
      LabeledEdit2.EditLabel.Caption:='A';
      LeGam.EditLabel.Caption:='Gam';
      LeBet.EditLabel.Caption:='Bet';
      RgParamO.Visible:=false;  LeKolEpsilon.Visible:=false; LeShagEpsilon.Visible:=false;
      LabeledEdit2.Visible:=true;
      LeDop.Visible:=true;
      LeOgran.Visible:=false;
      MeOgran.Visible:=false;
      LeGam.Visible:=True; LeBet.Visible:=True; LeX.Visible:=true;
      LePole.Visible:=true;
      ClbParam.Visible:=true;   LeP.Visible:=false;
      ClbParams.Visible:=false;
      MeKoordPole.Visible:=true;
      LeEpsGraph.Visible:=true;
      meGrad.Visible:=false;LaGrad.Visible:=false;
      LePar.Visible:=false;  LeIterSrez.Visible:=false;  CbSrez.Visible:=false;
      SgConstLamd.Visible:=false; LaConstLamd.Visible:=false;
      end;
    2:begin
      RadioGroup1.Visible:=False; RgMetodN.Visible:=false; RgMetodS.Visible:=true;
      CbFunctionO.Visible:=False; CbFunctionN.Visible:=false; CbFunctionS.Visible:=true;
      StringGrid1.Visible:=False; Stringgrid2.Visible:=false; StringGrid3.Visible:=False;  StringGrid4.Visible:=true; StringGrid5.Visible:=False;StringGrid6.Visible:=False;
      LabeledEdit3.EditLabel.Caption:='Left';
      LabeledEdit4.EditLabel.Caption:='Right';
      LeGam.EditLabel.Caption:='Mu';
      LeBet.EditLabel.Caption:='Bet';
      LeDop.Visible:=false;;
      RgParamO.Visible:=false;  LeKolEpsilon.Visible:=false; LeShagEpsilon.Visible:=false;
      LabeledEdit2.Visible:=false;
      LeOgran.Visible:=true;
      MeOgran.Visible:=true;
      LeGam.Visible:=True; LeBet.Visible:=True; LeX.Visible:=true;
      LePole.Visible:=true;
      MeKoordPole.Visible:=true;
      ClbParam.Visible:=false; LeP.Visible:=true;
      RgXyDg.Visible:=false;
      ClbParams.Visible:=true;
      LeEpsGraph.Visible:=true;
      LeX1.Visible:=false;
      meGrad.Visible:=false;  LaGrad.Visible:=false;
      LePar.Visible:=true;  LeIterSrez.Visible:=true;  CbSrez.Visible:=true;
      SgConstLamd.Visible:=false; LaConstLamd.Visible:=false;
      end;
    end;
end;

procedure TForm1.BtTimerClick(Sender: TObject);
begin
Form1.Visible:=false;
Form2.Visible:=true;
end;

procedure TForm1.RgMetodNClick(Sender: TObject);
begin
  If RgMetodN.ItemIndex=0 then
    begin
    StringGrid2.Visible:=true;
    StringGrid3.Visible:=False;
    StringGrid6.Visible:=False;
    LePar.Visible:=false;  LeIterSrez.Visible:=false;  CbSrez.Visible:=false;
    RgXyDg.Visible:=false;
    LeX1.Visible:=false;
    LeGam.Visible:=true;
    LeBet.Visible:=true;
    LabeledEdit2.Visible:=true;
    ClbParam.Visible:=true;
    LeDop.Visible:=true;
    LeDop.EditLabel.Caption:='Alf';
    meGrad.Visible:=false; LaGrad.Visible:=false;
    end
  else
  If RgMetodN.ItemIndex=1 then
    begin
    StringGrid2.Visible:=False;ClbParam.Visible:=false;
    StringGrid3.Visible:=true;
    StringGrid6.Visible:=False;
    LePar.Visible:=true;  LeIterSrez.Visible:=true;  CbSrez.Visible:=true;
    RgXyDg.Visible:=true;
    LeX1.Visible:=false;
    LeGam.Visible:=false;
    LeBet.Visible:=false;
    LabeledEdit2.Visible:=false;
    LeDop.Visible:=false;
    meGrad.Visible:=false; LaGrad.Visible:=false;
    end
  else
  If RgMetodN.ItemIndex=2 then
    begin
    StringGrid2.Visible:=False; ClbParam.Visible:=false;
    StringGrid3.Visible:=true;
    StringGrid6.Visible:=False;
    LePar.Visible:=false;  LeIterSrez.Visible:=false;  CbSrez.Visible:=false;
    LeX1.Visible:=true;
    RgXyDg.Visible:=false;
    LeGam.Visible:=true;
    LeBet.Visible:=false;
    LeDop.Visible:=true;
    LeDop.EditLabel.Caption:='Delt';
    LabeledEdit2.Visible:=false;
    meGrad.Visible:=false; LaGrad.Visible:=false;
    end
  else
  If (RgMetodN.ItemIndex=3) or (RgMetodN.ItemIndex=4) or (RgMetodN.ItemIndex=5) then
    begin
    StringGrid2.Visible:=False; ClbParam.Visible:=false;
    StringGrid3.Visible:=false;
    StringGrid6.Visible:=true;
    LePar.Visible:=false;  LeIterSrez.Visible:=false;  CbSrez.Visible:=false;
    LeX1.Visible:=false;
    LeGam.Visible:=false;
    RgXyDg.Visible:=false;
    LeBet.Visible:=false;
    LabeledEdit2.Visible:=false;
    meGrad.Visible:=true;
    LaGrad.Visible:=true;
    LeDop.Visible:=false;
    end;
end;

procedure TForm1.RgMetodSClick(Sender: TObject);
begin
  If RgMetodS.ItemIndex=2 then
    begin
    LeGam.EditLabel.Caption:='Bet1';
    LeBet.EditLabel.Caption:='Bet2';
    LeDop.EditLabel.Caption:='Mu1';
    LabeledEdit2.EditLabel.Caption:='Mu2';
    LabeledEdit2.Visible:=true;
    LeDop.Visible:=true;
    StringGrid5.Visible:=true;
    StringGrid4.Visible:=False;
    SgConstLamd.Visible:=true; LaConstLamd.Visible:=true;
    end
  else
    begin
    LeGam.EditLabel.Caption:='Mu';
    LeBet.EditLabel.Caption:='Bet';
    StringGrid5.Visible:=False;
    StringGrid4.Visible:=true;
    SgConstLamd.Visible:=false; LaConstLamd.Visible:=false;
    end;
end;

Procedure CopyGrid(T2,T1:TStringGrid);
  var
  i,j:Word;
  begin
  T2.ColCount:=T1.ColCount;
  for i:=0 to T2.ColCount-1 do
    T2.ColWidths[i]:=T1.ColWidths[i];
  T2.RowCount:=T1.RowCount;
  For j:=0 to T2.RowCount+1 do
    For i:=0 to T2.ColCount do
      T2.Cells[i,j]:=T1.Cells[i,j];
  end;

procedure TForm1.BtTabeledClick(Sender: TObject);
begin
  Form3.Visible:=true;
  If RgMetod.ItemIndex=0 then
    CopyGrid(Form3.StringGrid1,Form1.StringGrid1);
  If RgMetod.ItemIndex=1 then
    begin
    If RgMetodN.ItemIndex=0 then
      CopyGrid(Form3.StringGrid1,Form1.StringGrid2);
    If (RgMetodN.ItemIndex=1) or (RgMetodN.ItemIndex=2) then
      CopyGrid(Form3.StringGrid1,Form1.StringGrid3);
    If (RgMetodN.ItemIndex=3) or (RgMetodN.ItemIndex=4) or (RgMetodN.ItemIndex=5)  then
      CopyGrid(Form3.StringGrid1,Form1.StringGrid6);
    end;
  If RgMetod.ItemIndex=2 then
    begin
    If (RgMetodS.ItemIndex=0) or (RgMetodS.ItemIndex=1) then
      CopyGrid(Form3.StringGrid1,Form1.StringGrid4);
    If RgMetodS.ItemIndex=2 then
      CopyGrid(Form3.StringGrid1,Form1.StringGrid5);
    end;
end;

procedure TForm1.RgParamOClick(Sender: TObject);
begin
  if RgParamO.ItemIndex=0 then
       begin LeKolEpsilon.Visible:=false; LeShagEpsilon.Visible:=false; end
  else begin LeKolEpsilon.Visible:=true; LeShagEpsilon.Visible:=true; end;
end;

procedure TForm1.ClbParamClick(Sender: TObject);
begin
  if ClbParam.Checked[2] then
    LeGam.Visible:=false
  else
    LeGam.Visible:=true;
  if ClbParam.Checked[3] then
    Lebet.Visible:=false
  else
    Lebet.Visible:=true;
end;

procedure TForm1.LePoleChange(Sender: TObject);
var
i:word;
begin
  MeKoordPole.Lines.Clear;
  For i:=1 to StrToInt(LePole.Text) do
    MeKoordPole.Lines.Add('0');
end;

end.  
