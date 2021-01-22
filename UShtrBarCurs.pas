unit UShtrBarCurs;

interface

Uses UMnogomernie,SysUtils,Uform;

Procedure Shtraf(var K:Word);
Procedure Barier(var K:Word);
Procedure Cursach(var K:Word);

var
  Mu1,Mu2,
  Bet1,bet2,
  Ogr1,Ogr2:real;
  BolShtraf,BolBarier,BolKurs:boolean;
  NOgr:Word;
  VivOgr,ExitAlg:Boolean;
  p:word;
  Cur,ListCurs:PObList;          {Списки}
  NomCurs:byte;

implementation

uses Graphics;

Procedure Shtraf(var K:Word);
  var
  eps:real;
  begin
  p:=6;
  ConstLmd:=10;
  BolShtraf:=true;
  Bet1:=StrToFloat(Form1.LeGam.text);
  Mu1:=StrToFloat(Form1.LeDop.text);
  Eps:=StrToFloat(Form1.LabeledEdit1.Text);
  XykDhivs(2,eps,0,k);
{  NedlerMid(2,1,2,0.5,eps,0,k);}
  end;

Procedure Barier(var K:Word);
  var
  eps:real;
  begin
  BolBarier:=true;
   ConstLmd:=10;
  Bet2:=StrToFloat(Form1.LeBet.text);
  Mu2:=StrToFloat(Form1.LabeledEdit2.text);
  Eps:=StrToFloat(Form1.LabeledEdit1.Text);
  XykDhivs(2,eps,0,k);
  {NedlerMid(2,1,2,0.5,eps,0,k);}
  end;

Procedure Cursach(var K:Word);
  var
  eps:real;
  BetB,BetS:real;
  begin

  k:=1;
  BolKurs:=true;
  BetS:=StrToFloat(Form1.LeGam.text);
  Mu1:=StrToFloat(Form1.LeDop.text);
  BetB:=StrToFloat(Form1.LeBet.text);
  Mu2:=StrToFloat(Form1.LabeledEdit2.text);
  Eps:=StrToFloat(Form1.LabeledEdit1.Text);
  p:=StrToInt(Form1.LeP.Text);
  LengthTest:=10;

  NomCurs:=1;
  ConstLmd:=StrToFloat(Form1.SgConstLamd.Cells[0,NomCurs-1]);
  Bet1:=1;
  ExitAlg:=true;
  BolShtraf:=true;
  BolBarier:=false;
  XykDhivs(2,eps,0,k);
  k:=k-1;

  NomCurs:=2;
  ConstLmd:=StrToFloat(Form1.SgConstLamd.Cells[0,NomCurs-1]);
  Bet2:=1;
  ExitAlg:=false;
  BolBarier:=true;
  XykDhivs(2,eps,0,k);
  k:=k-1;

  If Form1.ClbParamS.Checked[6] then
    begin
    NomCurs:=2;
    ConstLmd:=StrToFloat(Form1.SgConstLamd.Cells[0,NomCurs-1]);
    Bet2:=BetB;
    ExitAlg:=true;
    BolBarier:=true;
    XykDhivs(2,eps,0,k);
    k:=k-1;
    end;

  NomCurs:=3;
  ConstLmd:=StrToFloat(Form1.SgConstLamd.Cells[0,NomCurs-1]);
  Bet1:=BetS;
  ExitAlg:=false;
  BolBarier:=false;

  XykDhivs(2,eps,0,k);

  end;


end.
