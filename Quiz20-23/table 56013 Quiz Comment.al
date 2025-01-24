table 56013 "Quiz Comment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "Document No."; Code[20]) { }
        field(56001; "Comment No."; Decimal) { }
        field(56002; "Comment"; Text[250]) { }
    }

    keys
    {
        key(PK; "Document No.", "Comment No.")
        {
            Clustered = true;
        }
    }
}