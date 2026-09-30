# Flutter + Dart — Bộ cấu trúc và mã mẫu 9 lab

Đọc `docs/HUONG_DAN_9_LAB.md` để làm từng bài.

## Phạm vi

Bám theo chín tiêu đề trong ảnh: I Am Rich, MiCard, Dicee, Magic 8 Ball, Xylophone, Quizzler, Destini, BMI Calculator, Clima.
Ảnh không có đề chi tiết hoặc rubric. Checklist và thiết kế ở đây là phương án đề xuất để học và hoàn thiện các mục tiêu tương ứng; không khẳng định trùng hoàn toàn yêu cầu giảng viên. Hai dòng Team project là mốc bài nhóm, không phải Lab 10/11 và chưa có nội dung để triển khai.

## Bộ tải về có gì?

- `templates/`: mã Dart, pubspec.yaml, assets và test của 9 lab.
- `scripts/setup.ps1`: tạo 9 ứng dụng Android/iOS/Web bằng Flutter đang cài trên máy rồi chép mã mẫu vào `apps/`.
- `scripts/verify.ps1`: định dạng, phân tích và chạy các test đã có.
- `docs/HUONG_DAN_9_LAB.md`: cài đặt, kiến trúc, mục tiêu, thao tác, kiểm thử và lỗi thường gặp.
- `docs/CHECKLIST.md`: bảng kiểm và bằng chứng nộp bài.
- `flutter_9_labs.code-workspace`: mở cả 9 app bằng VS Code sau khi setup.
- `secrets.example.json`: ví dụ truyền API key cho Clima.

Các thư mục platform chưa được sinh trong ZIP. Đây là bộ mã nguồn mẫu + script khởi tạo, chưa phải APK hay bản build đã kiểm thử trên thiết bị. Không chỉnh trực tiếp trong `templates/` sau setup; code ứng dụng bạn sẽ làm tiếp nằm trong `apps/`.

## Chạy nhanh trên Windows

1. Cài Flutter stable, Git và VS Code với extension Flutter/Dart. Chạy `flutter doctor -v` và xử lý lỗi cho nền tảng cần dùng.
2. Giải nén, ví dụ `D:\FlutterLabs\flutter_9_labs`, mở PowerShell tại đó.
3. Tạo một bài để bắt đầu nhanh:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\setup.ps1 -Only lab01_i_am_rich
cd .\apps\lab01_i_am_rich
flutter analyze
flutter run -d chrome
```

Lệnh ExecutionPolicy chỉ áp dụng cho tiến trình PowerShell đó. Đọc script trước khi chạy; script chỉ tạo thư mục dự án và gọi các lệnh Flutter. Không yêu cầu quyền quản trị.

Tạo toàn bộ từ thư mục gốc:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\setup.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\verify.ps1
```

Nếu đã tạo Lab 1, script sẽ bỏ qua thư mục đó và tiếp tục các bài khác; không ghi đè code đã làm. Nếu lần trước bị lỗi giữa chừng, vào thư mục bài đó chạy `flutter pub get` nếu mã mẫu đã được chép; nếu chưa, đổi tên thư mục tạo dở làm bản lưu rồi chạy lại setup cho riêng lab.

## Clima cần API key thật

Đăng ký OpenWeather và lấy API key cho Current Weather + Geocoding. Trong thư mục gốc:

```powershell
Copy-Item .\secrets.example.json .\apps\lab09_clima\secrets.json
```

Sửa giá trị trong `apps/lab09_clima/secrets.json`, sau đó:

```powershell
cd .\apps\lab09_clima
flutter run -d chrome --dart-define-from-file=secrets.json
```

Dùng Android: mở emulator hoặc kết nối điện thoại, chạy `flutter devices`, rồi thay `chrome` bằng ID thiết bị. Không cần key để đọc code hoặc chạy mock test; cần key và Internet để lấy thời tiết thật.

## Trạng thái kiểm tra

Đã kiểm tra sự hiện diện của source/assets, đường dẫn import nội bộ, YAML, WAV và cấu trúc gói ZIP bằng công cụ trong môi trường tạo file. Có test cho logic Quizzler, Destini, BMI và mock HTTP của Clima.

Môi trường tạo file không có Flutter/Dart/PowerShell, nên **chưa chạy** `flutter pub get`, `flutter analyze`, `flutter test`, script PowerShell, build Android/iOS/Web hay kiểm thử GPS/audio trên thiết bị. API thời tiết chưa được gọi bằng key thật. Chạy `verify.ps1` trên máy bạn trước khi xem mã mẫu là bản đã xác nhận chạy.

## Tài liệu chính thức

- https://docs.flutter.dev/install
- https://docs.flutter.dev/reference/create-new-app
- https://docs.flutter.dev/reference/flutter-cli
- https://pub.dev/packages/audioplayers
- https://pub.dev/packages/geolocator
- https://pub.dev/packages/http
- https://openweathermap.org/api/current
- https://openweathermap.org/api/geocoding-api

Phiên bản package là ràng buộc trong pubspec, không tuyên bố đã kiểm thử tổ hợp SDK/package. Dùng Flutter stable tương thích; giữ `pubspec.lock` của từng ứng dụng sau khi resolve thành công để tái lập môi trường.
