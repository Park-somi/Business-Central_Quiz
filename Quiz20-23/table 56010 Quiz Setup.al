table 56010 "Quiz Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; ID; Code[10]) { }
        field(56001; "Quiz Nos."; Code[20])
        {
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