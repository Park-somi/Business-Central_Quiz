table 56005 "Bicycle Brand"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; Code; Code[10]) { }
        field(56001; Name; Text[30]) { }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}