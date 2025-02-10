page 56014 "Amount per Currency"
{
    Caption = 'Amount per Currency';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Amount per Currency";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1; // 1 : Amount, 2: Unit Amount
                    AutoFormatExpression = Rec."Currency Code"; // 선택한 Currency Code에 따라서 입력할 수 있는 소수점 자릿수가 정해짐

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
                field("LCY Amount"; Rec."LCY Amount")
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
            }
        }

        //데이터를 저장하는 페이지에는 기본적으로 아래 2개의 factbox 구성함.
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    procedure GetLCYAmount()
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if (Rec."Currency Code" = '') or (Rec.Amount = 0) then
            exit;

        if Rec.Date = 0D then
            Rec.Date := WorkDate();

        Rec."LCY Amount" := CurrExchRate.ExchangeAmount(
            Rec.Amount,
            Rec."Currency Code",
            '', // 빈 문자열은 LCY를 의미
            Rec.Date // 비어있으면 자동으로 WorkDate()가 들어감
        );

        if Rec.Insert() then  // 새 레코드인 경우
            CurrPage.Update(false)
        else
            Rec.Modify();
    end;
}