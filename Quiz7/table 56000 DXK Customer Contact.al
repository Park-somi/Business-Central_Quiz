table 56000 "DXK Customer Contact"
{
    DataClassification = ToBeClassified;
    Caption = 'Customer Contact';
    LookupPageId = "DXK Customer Contact List";
    DrillDownPageId = "DXK Customer Contact List";

    fields
    {
        field(56000; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(56001; "Name"; Text[30])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    // 필드 그룹 기본 구성
    fieldgroups
    {
        fieldgroup(Dropdown; Code, Name) { }
        fieldgroup(Brick; Code, Name) { }
    }

    // 빈 값이 들어오면 에러 발생
    trigger OnInsert()
    begin
        Rec.TestField(Code);
    end;

    trigger OnModify()
    begin
        Rec.TestField(Code);
    end;

    // Quiz 11
    trigger OnDelete()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ErrorLbl: Label 'You cannot delete the record because it is being used in %1';
        TableNameUsed: Text;
    begin
        Customer.Reset();
        Customer.SetRange("DXK Customer Contact", Code);
        if Customer.FindFirst() then
            // Error('이 Contact는 Customer에서 사용 중이므로 삭제할 수 없습니다. ');
            TableNameUsed += Customer.TableCaption();

        SalesHeader.Reset();
        SalesHeader.SetRange("DXK Customer Contact", Code);
        if SalesHeader.FindFirst() then begin
            // Error('이 Contact는 Sales Header에서 사용 중이므로 삭제할 수 없습니다.');
            if TableNameUsed <> '' then
                TableNameUsed += ', ';
            TableNameUsed += SalesHeader.TableCaption();
        end;

        SalesLine.Reset();
        SalesLine.SetRange("DXK Customer Contact", Code);
        if SalesLine.FindFirst() then begin
            // Error('이 Contact는 Sales Line에서 사용 중이므로 삭제할 수 없습니다.');
            if TableNameUsed <> '' then
                TableNameUsed += ', ';
            TableNameUsed += SalesLine.TableCaption();
        end;

        if TableNameUsed <> '' then
            Error(ErrorLbl, TableNameUsed);
    end;

}