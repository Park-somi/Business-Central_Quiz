report 56001 "Copy Quiz"
{
    ProcessingOnly = true;
    Caption = 'Copy Quiz';
    ApplicationArea = All;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(QuizNo; SelectedQuizNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Quiz No.';
                        Editable = false;
                    }
                    field(CopyCommentLines; CopyCommentLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Comment Lines';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CopyCommentLines := false;
    end;

    trigger OnPreReport()
    var
        SourceQuiz: Record Quiz;
        NewQuiz: Record Quiz;
        QuizSetup: Record "Quiz Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        SourceQuizComment: Record "Quiz Comment";
        NewQuizComment: Record "Quiz Comment";
        SourceDimension: Record "Default Dimension for Quiz";
        NewDimension: Record "Default Dimension for Quiz";
    begin
        NewQuiz.Init();
        if QuizSetup.Get() then
            NewQuiz."Quiz No." := NoSeriesMgt.GetNextNo(QuizSetup."Quiz Nos.", WORKDATE, true); // Quiz No. 신규로 체번

        if SourceQuiz.Get(SelectedQuizNo) then begin
            NewQuiz."Quiz Name" := SourceQuiz."Quiz Name"; // 원천 Quiz Name 복사
            NewQuiz.Status := NewQuiz.Status::Open; // Status는 Open으로 설정
            NewQuiz."Dimension Set Id" := SourceQuiz."Dimension Set Id"; // Dimension Set Id 복사
            NewQuiz.Insert();

            // Copy Comment Lines 가 체크되어 있으면 Quiz Comment 복사
            if CopyCommentLines then begin
                SourceQuizComment.Reset();
                SourceQuizComment.SetRange("Document No.", SelectedQuizNo);
                if SourceQuizComment.FindSet() then
                    repeat
                        NewQuizComment.Init();
                        NewQuizComment."Document No." := NewQuiz."Quiz No.";
                        NewQuizComment."Comment No." := SourceQuizComment."Comment No.";
                        NewQuizComment.Comment := SourceQuizComment.Comment;
                        NewQuizComment.Insert();
                    until SourceQuizComment.Next() = 0;
            end;

            // Default Dimension for Quiz 복사
            SourceDimension.Reset();
            SourceDimension.SetRange("Quiz No.", SelectedQuizNo);
            if SourceDimension.FindSet() then begin
                repeat
                    NewDimension.Init();
                    NewDimension."Quiz No." := NewQuiz."Quiz No.";
                    NewDimension."Dimension Code" := SourceDimension."Dimension Code";
                    NewDimension."Dimension Value Code" := SourceDimension."Dimension Value Code";
                    NewDimension.Insert();
                until SourceDimension.Next() = 0;
            end;

        end;
    end;

    procedure SetSelectedQuizNo(QuizNo: Code[20])
    begin
        SelectedQuizNo := QuizNo;
    end;

    var
        SelectedQuizNo: Code[20];
        CopyCommentLines: Boolean;
}