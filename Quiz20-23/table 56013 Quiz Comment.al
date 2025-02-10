table 56013 "Quiz Comment"
{
    Caption = 'Quiz Comment';
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(56001; "Comment No."; Decimal)
        {
            Caption = 'Comment No.';
        }
        field(56002; "Comment"; Text[250])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(PK; "Document No.", "Comment No.")
        {
            Clustered = true;
        }
    }
}