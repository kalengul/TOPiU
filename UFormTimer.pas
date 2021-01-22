unit UFormTimer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  UOdnomernie, Grids,UForm;

type
  TForm2 = class(TForm)
    LaMessage: TLabel;
    LeB1: TLabeledEdit;
    LeA1: TLabeledEdit;
    RgAlgoritm: TRadioGroup;
    LeEps: TLabeledEdit;
    LeL: TLabeledEdit;
    RgMetod: TRadioGroup;
    LeX1: TLabeledEdit;
    LeX2: TLabeledEdit;
    LeBet: TLabeledEdit;
    Lealf: TLabeledEdit;
    BtOk: TButton;
    MeTime: TMemo;
    BtExit: TButton;
    RgViborTimer: TRadioGroup;
    LaFunction: TLabel;
    procedure BtOkClick(Sender: TObject);
    procedure BtExitClick(Sender: TObject);
    procedure RgMetodClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BtOkClick(Sender: TObject);
const
  alpha=0.618;
var
  epsilon,l,a,b,a1,b1:real;
  k:word;
  Time:Word;
  NatProg,KonProg:TDateTime;
begin
  Epsilon:=StrToFloat (LeEps.Text);
  L:= StrToFloat (Lel.Text);
  A1:= StrToFloat (LeA1.Text);
  B1:= StrToFloat (LeB1.Text);
  For Time:=1 to 640 do
  case RgMetod.ItemIndex of
    0:begin
    if L<2*Epsilon then
      begin
      ShowMessage('Алгоритм зациклился');
      exit;
      end;
     NatProg:=Now;
     A:=A1; b:=B1;
     If RgViborTimer.ItemIndex=0 then
       Dihotomii(A,B,Epsilon,L,Time*10,False,k);
     If RgViborTimer.ItemIndex=1 then
       begin
       A:=A1-5*Time;
       B:=B1+5*Time;
       Dihotomii(A,B,Epsilon,L,0,False,k);
       end;
     KonProg:=Now;
     MeTime.Lines.Add(TimeTostr(KonProg-NatProg));
     end;
   1:
     begin
     NatProg:=Now;
     If RgViborTimer.ItemIndex=0 then
       ZolotoeSetenie(A,B,Epsilon,L,Alpha,Time*10,False,k);
     If RgViborTimer.ItemIndex=1 then
       begin
       A:=A1-10*Time;
       B:=B1+10*Time;
       ZolotoeSetenie(A,B,Epsilon,L,Alpha,0,False,k);
       end;
     KonProg:=Now;
     MeTime.Lines.Add(TimeTostr(KonProg-NatProg));
     end;
   2:
     begin
     NatProg:=Now;
     If RgViborTimer.ItemIndex=0 then
       Fibonachi(A,B,Epsilon,L,Time*10,False,k);
     If RgViborTimer.ItemIndex=1 then
       begin
       A:=A1-10*Time;
       B:=B1+10*Time;
       Fibonachi(A,B,Epsilon,L,0,False,k);
       end;
     KonProg:=Now;
     MeTime.Lines.Add(TimeTostr(KonProg-NatProg));
     end;
   end;
  If RgViborTimer.ItemIndex=1 then
end;


procedure TForm2.BtExitClick(Sender: TObject);
begin
Form2.Visible:=false;
Form1.Visible:=true;
end;

procedure TForm2.RgMetodClick(Sender: TObject);
begin
  if Rgmetod.ItemIndex=0 then
    LaFunction.Caption:=Form1.CbFunctionO.Text;
  if Rgmetod.ItemIndex=1 then
    LaFunction.Caption:=Form1.CbFunctionN.Text;
end ;

procedure TForm2.FormCreate(Sender: TObject);
begin
 LaFunction.Caption:=Form1.CbFunctionO.Text;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Visible:=true;
end;

end.
