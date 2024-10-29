import Foundation

public struct APIError: Error {
    public let statusCode: Int
    public let resultCode: String
    public var message: String

    public init(statusCode: Int = 0, resultCode: String, message: String) {
        self.statusCode = statusCode
        self.resultCode = resultCode
        self.message = message
    }

    private enum CodingKeys: String, CodingKey {
        case resultCode
        case message
    }
}

extension APIError: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resultCode = try container.decode(String.self, forKey: .resultCode)
        message = try container.decode(String.self, forKey: .message)
        statusCode = 0
    }
}

extension APIError {
    // MARK: 24.11.13 (수) Update
    /// 예기치 못한 에러가 발생했습니다
    public static let X0001: String = "X0001"
    /// 입력 내용을 확인해 주세요
    public static let X0002: String = "X0001"
    /// 입력 내용 값이 올바르지 않습니다
    public static let X0003: String = "X0001"
    /// 요청 정보가 올바르지 않습니다.
    public static let X0004: String = "X0001"
    /// 존재하지 않는 회원입니다
    public static let US0001: String = "US0001"
    /// 유효하지 않은 권한입니다
    public static let US0002: String = "US0002"
    /// 차단된 회원입니다. 관리자에게 문의하세요
    public static let US0003: String = "US0003"
    /// 이미 가입된 계정명입니다
    public static let US0004: String = "US0004"
    /// 이미 존재하는 닉네임입니다
    public static let US0005: String = "US0005"
    /// 이미 가입된 가입 회원입니다
    public static let US0006: String = "US0006"
    /// 비밀번호에 사용 불가능한 문자가 포함 되어 있습니다
    public static let PW0001: String = "PW0001"
    /// 비밀번호 제약조건을 위배했습니다
    public static let PW0002: String = "PW0002"
    /// 비밀번호에 순차적인 문자열이 존재합니다
    public static let PW0003: String = "PW0003"
    /// 비밀번호가 일치하지 않습니다
    public static let LG0001: String = "LG0001"
    /// 등록된 계정이 없습니다. 회원가입 후 다시 시도해 주세요
    public static let LG0002: String = "LG0002"
    /// 인증 정보가 없거나 유효하지 않습니다
    public static let TK0001: String = "TK0001"
    /// 유효하지 않은 토큰입니다
    public static let TK0002: String = "TK0002"
    /// 유효하지 않은 토큰입니다
    public static let TK0003: String = "TK0003"
    /// 만료된 토큰입니다
    public static let OA0001: String = "OA0001"
    /// 토큰의 ID가 일치하지 않습니다
    public static let OA0002: String = "OA0002"
    /// 지원하지 않는 서비스 제공자입니다
    public static let OA0003: String = "OA0003"
    /// 유효하지 않은 토큰입니다
    public static let OA0004: String = "OA0004"
    /// 로그인 서비스 오류입니다
    public static let OA0005: String = "OA0005"
    /// 존재하지 않는 관리자입니다
    public static let AU0001: String = "AU0001"
    /// 이메일 전송에 실패했습니다
    public static let MV0001: String = "MV0001"
    /// 유효하지 않은 이메일 인증 코드입니다
    public static let MV0002: String = "MV0002"
    /// 존재하지 않는 이메일 인증 코드입니다
    public static let MV0003: String = "MV0003"
    /// 만료된 이메일 인증 코드입니다
    public static let MV0004: String = "MV0004"
    /// 이미 인증된 이메일입니다
    public static let MV0005: String = "MV0005"
    /// 지원하지 않는 OS 타입입니다.
    public static let DV0001: String = "DV0001"
    /// 시작일은 오늘 이후여야 합니다
    public static let MT0001: String = "MT0001"
    /// 종료일은 오늘로부터 7일 이내여야 합니다
    public static let MT0002: String = "MT0002"
    /// 시작일은 종료일보다 앞서야 합니다
    public static let MT0003: String = "MT0003"
    /// 최대 참가자 수는 2 이상이어야 합니다
    public static let MT0004: String = "MT0004"
    /// 최대 참가자 수는 20 이하여야 합니다
    public static let MT0005: String = "MT0005"
    /// 존재하지 않는 모임입니다
    public static let MT0006: String = "MT0006"
    /// 이미 참여한 모임입니다
    public static let MT0007: String = "MT0007"
    /// 모임 정원이 초과되었습니다
    public static let MT0008: String = "MT0008"
    /// 유효하지 않은 모임 상태입니다
    public static let MT0009: String = "MT0009"
    /// 모임 주최자가 아닙니다
    public static let MT0010: String = "MT0010"
    /// 이미 시작된 모임입니다
    public static let MT0011: String = "MT0011"
    /// 이미 종료된 모임입니다
    public static let MT0012: String = "MT0012"
    /// 수정할 수 없는 모임입니다
    public static let MT0013: String = "MT0013"
    /// 모임 주최자만 모임 내용을 수정할 수 있습니다
    public static let MT0014: String = "MT0014"
}
