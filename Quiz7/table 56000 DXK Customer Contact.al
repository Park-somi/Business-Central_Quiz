table 56000 "DXK Customer Contact"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "Code"; Code[10]) { }
        field(56001; "Name"; Text[30]) { }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    // Quiz 11
    trigger OnDelete()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Customer.SetRange("DXK Customer Contact", Code);
        if Customer.FindFirst() then
            Error('이 Contact는 Customer에서 사용 중이므로 삭제할 수 없습니다. ');

        SalesHeader.SetRange("DXK Customer Contact", Code);
        if SalesHeader.FindFirst() then
            Error('이 Contact는 Sales Header에서 사용 중이므로 삭제할 수 없습니다.');

        SalesLine.SetRange("DXK Customer Contact", Code);
        if SalesLine.FindFirst() then
            Error('이 Contact는 Sales Line에서 사용 중이므로 삭제할 수 없습니다.');
    end;

}