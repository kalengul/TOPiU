program PTopiy;

uses
  Forms,
  UForm in 'UForm.pas' {Form1},
  UOdnomernie in 'UOdnomernie.pas',
  UFormula in 'UFormula.pas',
  UFormTimer in 'UFormTimer.pas' {Form2},
  UMnogomernie in 'UMnogomernie.pas',
  UFormTabled in 'UFormTabled.pas' {Form3},
  UShtrBarCurs in 'UShtrBarCurs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
