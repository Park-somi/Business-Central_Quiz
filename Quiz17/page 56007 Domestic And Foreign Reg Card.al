page 56007 "Domestic And Foreign Reg Card"
{
    PageType = Card;
    SourceTable = "Domestic And Foreign Reg";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Nationality Type"; Rec."Nationality Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Nationality Type" = Rec."Nationality Type"::Domestic then begin
                            Rec."Country" := 'KOR';
                            Rec."Foreigner Registration No." := '';
                            IsCountryEditable := false;
                            IsDomesticVisible := true;
                            IsForeignVisible := false;
                        end else begin
                            Rec."Country" := '';
                            Rec."Domestic Registration No." := '';
                            IsCountryEditable := true;
                            IsDomesticVisible := false;
                            IsForeignVisible := true;
                        end;
                        CurrPage.Update(false);
                    end;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec.Country)
                {
                    ApplicationArea = All;
                    Editable = IsCountryEditable;
                }
                group(Domestic)
                {
                    Visible = IsDomesticVisible;

                    field("Domestic Registration No."; Rec."Domestic Registration No.")
                    {
                        ApplicationArea = All;
                        Numeric = true; // 숫자만 입력가능하도록 설정

                        trigger OnValidate()
                        var
                            i: BigInteger; // 변환할 데이터 타입에 맞는 변수 선언. 13자리 숫자이므로 BigInteger로 선언
                        begin
                            if StrLen(Rec."Domestic Registration No.") <> 13 then
                                Error('Domestic Registration No.는 정확히 13자리를 입력해야 합니다.');
                        end;
                    }
                }
                group(Foreigner)
                {
                    Visible = IsForeignVisible;

                    field("Foreigner Registration No."; Rec."Foreigner Registration No.")
                    {
                        ApplicationArea = All;
                        Numeric = true;

                        trigger OnValidate()
                        var
                            i: BigInteger;
                        begin
                            if StrLen(Rec."Foreigner Registration No.") <> 10 then
                                Error('Foreigner Registration No.는 정확히 10자리를 입력해야 합니다.');
                        end;
                    }
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

    var
        IsCountryEditable: Boolean;
        IsDomesticVisible: Boolean;
        IsForeignVisible: Boolean;

    trigger OnOpenPage()
    begin
        if Rec."Nationality Type" = Rec."Nationality Type"::Domestic then begin
            IsDomesticVisible := true;
            IsForeignVisible := false;
        end else begin
            IsDomesticVisible := false;
            IsForeignVisible := true;
        end;
    end;
}