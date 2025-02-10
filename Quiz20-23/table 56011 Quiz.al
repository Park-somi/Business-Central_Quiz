table 56011 Quiz
{
    Caption = 'Quiz';
    DataClassification = ToBeClassified;
    LookupPageId = "Quiz List";
    DrillDownPageId = "Quiz Card";

    fields
    {
        field(56000; "Quiz No."; Code[20])
        {
            Caption = 'Quiz No.';
        }
        field(56001; "Quiz Name"; Text[20])
        {
            Caption = 'Quiz Name';
        }
        field(56002; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Released;
            InitValue = Open;
        }
        field(56003; "Dimension Set Id"; Integer)
        {
            Caption = 'Dimension Set Id';
        }
    }

    keys
    {
        key(PK; "Quiz No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        QuizSetup: Record "Quiz Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        // Quiz Setup에서 Quiz Nos. 값 가져오기
        if QuizSetup.Get() then begin
            // Rec.Init();
            QuizSetup.TestField("Quiz Nos."); // Quiz Setup 테이블의 Quiz Nos. 필드가 비어있는지 체크 -> 비어있다면 에러 발생
            Rec."Quiz No." := NoSeriesMgt.GetNextNo(QuizSetup."Quiz Nos.", WORKDATE, true); // Quiz Nos. 번호 시리즈 사용
        end
    end;

    trigger OnModify()
    begin
        //Status의 상태가 Released 인 레코드 수정 방지
        Rec.TestField(Status, Rec.Status::Open);
    end;

    trigger OnDelete()
    var
        QuizComment: Record "Quiz Comment";
    begin
        //Status의 상태가 Released 인 레코드 삭제 방지
        Rec.TestField(Status, Rec.Status::Open);

        QuizComment.Reset();
        QuizComment.SetRange("Document No.", Rec."Quiz No.");
        if QuizComment.FindSet() then
            QuizComment.DeleteAll(); // 해당 Quiz No.에 해당하는 모든 Quiz Comment 삭제
    end;
}