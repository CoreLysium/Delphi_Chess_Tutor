unit HelperFunctions_u;

interface

Uses
  IdHashMessageDigest, SysUtils;

Function HashPassword(const sPassword: String): String;

implementation

Function HashPassword(Const sPassword: String): String;
Begin
  Result := '';
  with TIdHashMessageDigest5.Create do
    Try
      Result := HashStringAsHex(sPassword); // Uses a non reversible algorithm to hash the password string so it is not visible as plaintext.
    Finally
      Destroy;
    End;
End;

end.
