table 56014 "Amount per Currency"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "No."; Integer) { AutoIncrement = true; }
        field(56001; "Currency Code"; Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(56002; "Amount"; Decimal) { }
        field(56003; "LCY Amount"; Decimal) { }
        field(56004; Date; Date) { }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}