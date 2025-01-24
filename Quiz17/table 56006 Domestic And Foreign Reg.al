table 56006 "Domestic And Foreign Reg"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "No."; Integer) { AutoIncrement = true; DataClassification = SystemMetadata; }
        field(56001; "Nationality Type"; Option)
        {
            OptionMembers = Domestic,Foreigner;
            InitValue = Domestic;
        }
        field(56002; "Last Name"; Code[50]) { } // 대소문자 구분 O
        field(56003; "First Name"; Text[100]) { } // 대소문자 구분 X
        field(56004; "Country"; Code[10])
        {
            TableRelation = Language.Code;
            InitValue = 'KOR';
        }
        field(56005; "Domestic Registration No."; Code[13]) { }
        field(56006; "Foreigner Registration No."; Code[10]) { }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}