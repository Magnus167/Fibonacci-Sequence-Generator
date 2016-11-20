unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Math;

type

  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;

    Label10: TLabel;
    Button2: TButton;
    Button3: TButton;
    Edit2: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    function fibb(n: Int64): UInt64;
    function fibbnm(n: Int64): UInt64;
    function fibbi(n: Int64): UInt64;
    function fibbg(n: Extended): Extended;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tb, ta, td: TTime;
  c, t: Double;
  atb, ata, atd: Cardinal;
  alpha: Integer;
  save: TstringList;
  mem: Array [0 .. 90000, 0 .. 1] of UInt64;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
inp : String;
begin
  c := 0;
  t := 0;
  if Edit1.Text = '' then
    Edit1.Text := '0';
  inp := Edit1.Text;

  Screen.Cursor := crHourglass;
  tb := Time;
  atb := GetTickCount;
  if RadioButton1.Checked = True then
    Label1.Caption := UIntToStr(fibb(StrToInt(Edit1.Text)))
  else if RadioButton2.Checked = True then
    Label1.Caption := UIntToStr(fibbnm(StrToInt(Edit1.Text)))
  else if RadioButton3.Checked = True then
    Label1.Caption := UIntToStr(fibbi(StrToInt(Edit1.Text)))
  else
    Label1.Caption := FloatToStr(fibbg(StrToInt(Edit1.Text)));

  ata := GetTickCount;
  ta := Time;
  Screen.Cursor := crDefault;
  atd := ata - atb;
  if StrToInt(Edit1.Text) > 93 then
    showmessage('Accuracy for values over 93 is not guarantied. ');

  Label4.Caption := IntToStr(atd); // milliseconds ;
  Label4.Caption := Label4.Caption + ' milliseconds';
  Label3.Caption := FloatToStr(atd / 1000);
  Label3.Caption := Label3.Caption + ' seconds';
  Label7.Caption := 'Time added = ';
  Label7.Caption := Label7.Caption + TimeToStr(tb);
  Label8.Caption := 'Time completed = ';
  Label8.Caption := Label8.Caption + TimeToStr(ta);
  Label9.Caption := IntToStr((StrToInt(FloatToStr(atd)) Div 1000) Div 60);
  Label9.Caption := 'About ' + Label9.Caption + ' minutes';

  Timer1.Enabled := False;

  Label5.Caption := '';
  Label5.Caption := FloatToStr(c);

  save.Add('Number-');
  save.Add(Edit1.Text);
  save.Add('Result -');
  save.Add(Label1.Caption);
  save.Add('Fibb(x) function called -');
  save.Add(Label5.Caption);
  save.Add(Label3.Caption);
  save.Add(Label4.Caption);
  save.Add(Label9.Caption);
  save.Add(TimeToStr(Time));
  save.SaveToFile(((GetCurrentDir) + '\fibbc.txt');
  save.Clear;
  Label10.Caption := 'Term Number : ' + Edit1.Text;

  Edit1.Text := '';
  Edit2.Text := '';
    if StrToInt(Inp) < 94 then

    Edit2.Text := Label1.Caption;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Int64;
  save: TstringList;
  tn: String;
begin

  c := 0;
  t := 0;
  if Edit1.Text = '' then
    Edit1.Text := '0';
  save := TstringList.Create;
  for i := 0 to StrToInt(Edit1.Text) do
  begin
    tn := 'Term Number : ' + IntToStr(i) + ' of the Fibonacci Sequence is >> ' +
      UIntToStr(fibb(i)) + ' at ' + TimeToStr(Time) + ' on ' + DateToStr(date) +
      ' , fibb(x) called ' + FloatToStr(c);
    save.Add(tn);
  end;

  save.SaveToFile('C:\Users\Bellatrix\Desktop\fibbclist.txt');
  showmessage('Saved');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  x, b: Int64;
begin
  for x := 0 to 90000 do
    for b := 0 to 1 do
      mem[x, b] := 0;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Button1Click(Sender);
    Key := #0;
  end;
  if NOT(Key in [#13, #08, '0' .. '9']) then
    Key := #0;

end;

function TForm1.fibb(n: Int64): UInt64;
var
  // sc, sr: Int64;
  st: UInt64;
begin

  // if n>18446744073709551615 then showmessage('Large') ;

  begin
    st := 0;
    c := c + 1;
    if NOT(n > 90000) then
    begin
      if mem[n, 0] = 1 then
        result := mem[n, 1]
      else if n < 2 then
        result := (n)
      else

      begin
        st := fibb(n - 1) + fibb(n - 2);

        mem[n, 0] := 1;
        mem[n, 1] := st;
        result := st;

      end;

    end

    else
      result := (fibb(n - 1) + fibb(n - 2));

  end;

end;

function TForm1.fibbg(n: Extended): Extended;
var
  rtf, r: Extended;
begin
  c := 1;
  rtf := power(5, 0.5);

  r := (power(((1 + rtf) / 2), n) - power(((1 - rtf) / 2), n)) / rtf;
  result := r;

end;

function TForm1.fibbi(n: Int64): UInt64;
var
  i, a, b, ci, d: UInt64;
begin
  a := 1;
  b := 0;
  c := 0;
  for i := 0 to n - 1 do
  begin
    c := c + 1;
    ci := b + a;
    c := c + 1;
    b := a;
    c := c + 1;
    a := ci;
    c := c + 1;
  end;

  result := a;
end;

function TForm1.fibbnm(n: Int64): UInt64;
begin
  c := c + 1;
  if n < 2 then
    result := n
  else
    result := fibbnm(n - 1) + fibbnm(n - 2);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ar1, ar2: Int64;
begin
  Timer1.Enabled := False;
  save := TstringList.Create;
  Label5.Caption := '';
  Label7.Caption := '';
  Label8.Caption := '';

  for ar1 := 0 to 50000 do
    for ar2 := 0 to 1 do
      mem[ar1, ar2] := 0;
  RadioButton1.Checked := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  t := t + 1;

end;

end.
