table 56014 "Amount per Currency"
{
    Caption = 'Amount per Currency';
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(56001; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(56002; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(56003; "LCY Amount"; Decimal)
        {
            Caption = 'LCY Amount';
        }
        field(56004; Date; Date)
        {
            Caption = 'Date';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}