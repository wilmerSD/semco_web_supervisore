class RequestNewNoteModel {
    String pComeOrden;
    String pComeClienteId;
    String pComeCompaniaId;
    String pComePersonalId;
    int pHora;
    int pMinuto;
    int pComeTipoComentario;
    String pComeComentario;
    bool pSendEmail;
    String pComeOtros2;
    String pDateOfControl;
    String pCambioEstado;
    bool pRevizar;
    int pOpAvance;
    String pDateClose;
    String pDateOfReview;
    String pPrivateNote;
    String pRecommendation;
    String pQualityOfWork;
    String pWorkInTeam;
    String pIndependenceResult;

    RequestNewNoteModel({
        required this.pComeOrden,
        required this.pComeClienteId,
        required this.pComeCompaniaId,
        required this.pComePersonalId,
        required this.pHora,
        required this.pMinuto,
        required this.pComeTipoComentario,
        required this.pComeComentario,
        required this.pSendEmail,
        required this.pComeOtros2,
        required this.pDateOfControl,
        required this.pCambioEstado,
        required this.pRevizar,
        required this.pOpAvance,
        required this.pDateClose,
        required this.pDateOfReview,
        required this.pPrivateNote,
        required this.pRecommendation,
        required this.pQualityOfWork,
        required this.pWorkInTeam,
        required this.pIndependenceResult,
    });

    Map<String, dynamic> toJson() => {
        "iComeOrden": pComeOrden,
        "iComeClienteId": pComeClienteId,
        "iComeCompaniaId": pComeCompaniaId,
        "iComePersonalId": pComePersonalId,
        "iHora": pHora,
        "iMinuto": pMinuto,
        "iComeTipoComentario": pComeTipoComentario,
        "iComeComentario": pComeComentario,
        "iSendEmail": pSendEmail,
        "iComeOtros2": pComeOtros2,
        "iDateOfControl": pDateOfControl,
        "iCambioEstado": pCambioEstado,
        "iRevizar": pRevizar,
        "iOpAvance": pOpAvance,
        "iDateClose": pDateClose,
        "iDateOfReview": pDateOfReview,
        "iPrivateNote": pPrivateNote,
        "iRecommendation": pRecommendation,
        "iQualityOfWork": pQualityOfWork,
        "iWorkInTeam": pWorkInTeam,
        "iIndependenceResult": pIndependenceResult,
    };
}