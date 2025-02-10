table 56010 "Quiz Setup"
{
    Caption = 'Quiz Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; ID; Code[10])
        {
            Caption = 'ID';
        }
        field(56001; "Quiz Nos."; Code[20])
        {
            Caption = 'Quiz Nos.';
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}