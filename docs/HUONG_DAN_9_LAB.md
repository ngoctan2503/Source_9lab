# Hướng dẫn thực hiện 9 lab Flutter + Dart

## 1. Chọn công nghệ và phạm vi

Dart là ngôn ngữ; Flutter là bộ công cụ xây dựng giao diện đa nền tảng. Danh sách trong ảnh đã nêu Flutter/Dart, nên dùng đúng bộ này. Cùng mã Dart có thể dùng cho Android, iOS và Web; mỗi nền tảng vẫn cần cấu hình và kiểm thử riêng, đặc biệt âm thanh và vị trí.

Mục tiêu thực hành: chạy Android + Web trước. Windows có thể phát triển/chạy Android và Web; build iOS cần macOS + Xcode. Các file Kotlin/Swift do Flutter sinh là phần vỏ native, không có nghĩa bạn phải viết lại chín bài bằng Kotlin hoặc Swift.

Tổ chức một thư mục môn học chứa chín app độc lập. Lợi ích: mỗi bài có package, assets, lịch sử thay đổi và file nộp riêng; Lab 9 lỗi API không chặn Lab 1. Không dùng backend, Firebase, đăng nhập hoặc database vì chưa cần cho chín tiêu đề. Chỉ Clima gọi dịch vụ thời tiết.

Đây là lộ trình và mã mẫu dựa trên tiêu đề trong ảnh, không phải bản chép rubric chưa được cung cấp. Nếu giảng viên có ảnh UI, asset hoặc yêu cầu cụ thể, đối chiếu và điều chỉnh trước khi nộp.

## 2. Chuẩn bị môi trường trên Windows

1. Cài Git for Windows.
2. Cài Flutter SDK bản stable theo https://docs.flutter.dev/install. Nếu cài thủ công, đặt ở đường dẫn đơn giản, ví dụ `C:\dev\flutter`; thêm `C:\dev\flutter\bin` vào PATH rồi mở lại terminal. Dart đi kèm Flutter.
3. Cài VS Code, extension Flutter và Dart.
4. Muốn chạy Android, cài Android Studio, Android SDK, Platform Tools và emulator trong Device Manager. Tạo máy ảo rồi khởi động, hoặc bật Developer options + USB debugging trên điện thoại và chấp nhận kết nối máy tính.
5. Chạy các lệnh sau, xem lỗi cụ thể thay vì cài lại mọi thứ:

```powershell
flutter --version
flutter doctor -v
flutter doctor --android-licenses
flutter devices
```

`flutter doctor --android-licenses` dùng khi đã có Android SDK/command-line tools. Nếu chỉ chạy Chrome trước, cảnh báo về Visual Studio desktop không phải điều kiện để chạy Web. Dùng JDK/Gradle tương thích với bản Flutter/Android Studio hiện tại; không sao chép cấu hình Java 11 hoặc compileSdk cũ từ dự án khác.

6. Chạy `scripts/setup.ps1` như README. Script sinh `android/`, `ios/`, `web/` bằng Flutter trên máy rồi chép mã nguồn mẫu. Dùng `--empty` để không mang test counter mặc định sang các bài.
7. Mở riêng `apps/lab01_i_am_rich` trong VS Code để dễ chọn thiết bị. Có thể mở file workspace nếu muốn thấy đủ 9 bài.

Nếu tạo thủ công một lab ở đường dẫn khác:

```powershell
flutter create --empty --platforms=android,ios,web --org com.example.flutterlabs lab01_i_am_rich
```

Chép nội dung `templates/lab01_i_am_rich/` vào thư mục vừa tạo, sau đó `flutter pub get`. Với Lab 9, cách thủ công cần thêm quyền theo mục 13; script đã thêm quyền Android và mô tả iOS.

## 3. Cấu trúc và trách nhiệm

| Đường dẫn | Vai trò |
|---|---|
| `templates/labXX_.../` | Bản mẫu ban đầu trong ZIP |
| `apps/labXX_.../` | Dự án được sinh để chạy, chỉnh sửa và nộp |
| `lib/main.dart` | Điểm vào `main`, `runApp`, `MaterialApp`, theme |
| `lib/screens/` | Màn hình và trạng thái giao diện |
| `lib/widgets/` | Thành phần UI dùng lại khi thực sự cần |
| `lib/models/` | Cấu trúc dữ liệu như Question, StoryNode, Weather |
| `lib/data/` | Danh sách câu hỏi và các node câu chuyện |
| `lib/logic/` | Quy tắc trả lời, chuyển nhánh và phép tính |
| `lib/services/` | Tương tác âm thanh, vị trí hoặc HTTP |
| `assets/images/`, `assets/audio/` | Tài nguyên được khai báo trong pubspec |
| `test/` | Test logic và mock API của Lab 6–9 |
| `pubspec.yaml` | Tên package, ràng buộc SDK, dependencies và assets |
| `pubspec.lock` | Phiên bản đã resolve; giữ lại trong Git của app |
| `android/`, `ios/`, `web/` | Cấu hình theo nền tảng, sinh bởi Flutter |

Không bắt buộc tạo đủ tất cả tầng trong mọi app. Lab 1–4 chỉ cần `main.dart` và màn hình. Lab 5 thêm audio service. Lab 6–7 tách model/data/logic. Lab 8 tách phép tính, widget và màn hình kết quả. Lab 9 tách service và model.

`StatefulWidget`/`setState` đủ cho quy mô này. Chưa cần Bloc, Riverpod, Clean Architecture hay monorepo tooling. Logic thuần Dart dễ kiểm tra hơn khi không đặt lẫn trong `build()`.

## 4. Quy trình làm mỗi bài

1. Đọc mục tiêu và chạy bản mẫu.
2. Đọc `main.dart`, rồi `screens/home_screen.dart`, sau đó các file được import.
3. Tự thay đổi một phần nhỏ để hiểu cơ chế; dùng hot reload khi sửa UI. Thêm asset/plugin hoặc đổi cấu hình platform thường cần chạy lại app.
4. Thực hiện checklist, chụp ảnh kết quả và ghi lỗi/cách sửa.
5. Chạy analyze, test nếu có và chạy thực tế trên Android/Web.
6. Lưu code và bằng chứng của bài trước khi sang bài tiếp theo.

Từ thư mục một ứng dụng:

```powershell
flutter pub get
dart format lib
flutter analyze
flutter run -d chrome
```

Với Lab 6–9, thêm `flutter test`. Dừng app bằng `q` trong terminal. Khi đang chạy, `r` hot reload; `R` hot restart sẽ khởi tạo lại state.

## 5. Lab 1 — I Am Rich

**Mục tiêu:** hiểu điểm vào Flutter, cây widget và tài nguyên cục bộ.

**Đã có:** nền tối, AppBar, ảnh kim cương PNG và dòng chữ I AM RICH. Ảnh được vẽ riêng cho bộ mẫu.

**Thực hiện:**

1. Đọc `main()` gọi `runApp`, rồi `MaterialApp(home: HomeScreen())`.
2. Trong `home_screen.dart`, xác định Scaffold, AppBar, Center, Column, Image.asset, Text.
3. Mở `assets/images/diamond.png`; xem khai báo thư mục ảnh trong `pubspec.yaml`.
4. Đổi màu nền, tiêu đề hoặc lời giới thiệu để kiểm chứng hot reload.
5. Chạy trên Chrome và Android, chụp một ảnh màn hình.

**Đạt khi:** ảnh hiện đúng, chữ rõ, không có lỗi asset, mở app không còn màn counter mặc định.

**Vấn đáp:** `pubspec.yaml` làm gì? Vì sao dùng StatelessWidget? Image.asset khác ảnh tải từ mạng ở đâu?

**Lỗi hay gặp:** sai chữ hoa/thường hoặc đường dẫn ảnh; sai thụt dòng YAML; thêm asset mà chưa chạy pub get/restart.

## 6. Lab 2 — MiCard

**Mục tiêu:** bố cục danh thiếp, căn chỉnh, tái sử dụng widget Material.

**Đã có:** CircleAvatar, tên, vai trò, đường phân cách, hai Card chứa điện thoại và email. Dữ liệu trong mẫu là placeholder; hãy thay bằng thông tin bạn muốn nộp.

**Thực hiện:**

1. Thay `assets/images/avatar.png` bằng avatar mong muốn, giữ đúng tên hoặc sửa AssetImage.
2. Thay tên, vai trò, điện thoại và email trong màn hình.
3. Quan sát Column xếp dọc; Card + ListTile ghép icon và chữ; SizedBox tạo khoảng cách.
4. Thử cửa sổ hẹp/ngang. SingleChildScrollView tránh thiếu chỗ theo chiều dọc, ConstrainedBox hạn chế danh thiếp quá rộng trên Web.
5. Điều chỉnh cỡ chữ và khoảng cách sao cho đọc rõ.

**Đạt khi:** đầy đủ avatar/tên/vai trò/liên hệ; không tràn trên thiết bị dùng demo. Card liên hệ hiện là nội dung tĩnh; nhấn để gọi/gửi mail là mở rộng tùy chọn.

**Vấn đáp:** SafeArea giúp gì? Padding khác Margin của Container ra sao? Vì sao không dùng tọa độ tuyệt đối?

## 7. Lab 3 — Dicee

**Mục tiêu:** state, sự kiện và Random.

**Đã có:** hai ảnh xúc xắc, nhấn ảnh hoặc nút để gieo lại, hiển thị tổng.

**Thực hiện:**

1. Xác định `_left`, `_right` là state ban đầu bằng 1; Random tồn tại cùng vòng đời State.
2. Đọc `_roll()`: `nextInt(6)` cho 0–5, cộng 1 để thành 1–6.
3. Sau khi gán trong setState, Flutter dựng lại giao diện và đường dẫn dice tương ứng.
4. Nhấn ít nhất 20 lần; ghi nhận hai mặt luôn nằm trong 1–6, tổng nằm trong 2–12.
5. Thử nhấn cả hai vùng ảnh và nút. Hai lần gieo có thể trùng kết quả; đó là hành vi ngẫu nhiên hợp lệ.

**Đạt khi:** cả hai mặt cập nhật, không gọi ảnh dice0/dice7, tổng khớp với mặt xúc xắc.

**Vấn đáp:** Vì sao đổi biến mà thiếu setState thì UI có thể chưa cập nhật? Vì sao không sinh số ngẫu nhiên ngay trong build()?

## 8. Lab 4 — Magic 8 Ball

**Mục tiêu:** tự vận dụng state và list để làm bài challenge.

**Đã có:** quả cầu vẽ bằng Container tròn, lời nhắc và năm câu trả lời Có/Không dạng ngẫu nhiên. Không cần package bên ngoài.

**Thực hiện:**

1. Đọc danh sách `_answers`; thêm hai câu trả lời mới.
2. Kiểm tra cách chọn chỉ số theo `answers.length` để thêm phần tử không phải sửa phạm vi random.
3. Chạm quả cầu: đổi `_answer` bằng setState.
4. Kiểm tra chữ dài vẫn nằm trong quả cầu; rút gọn câu trả lời nếu cần.
5. Nếu giảng viên cung cấp các ảnh ball1–ball5, thay Container bằng Image.asset theo chỉ số và khai báo assets.

**Đạt khi:** mỗi lần chạm gọi logic chọn câu trả lời hợp lệ; không vượt chỉ số; UI đọc rõ. Không yêu cầu câu trả lời phải khác lần trước.

**Vấn đáp:** điểm giống/khác Dicee là gì? Điều gì xảy ra nếu danh sách đáp án rỗng?

## 9. Lab 5 — Xylophone

**Mục tiêu:** thêm Dart/Flutter package, dùng asset âm thanh và tách xử lý khỏi UI.

**Đã có:** bảy phím màu Đô–Si, bảy file WAV tự tổng hợp, AudioService sử dụng audioplayers.

**Thực hiện:**

1. Xem dependency `audioplayers` và mục `assets/audio/` trong pubspec.
2. `flutter pub get`, chạy lại app vì đây là plugin.
3. Đọc `List.generate(7, ...)`: mỗi phím truyền chỉ số 0–6.
4. Đọc AudioService: AssetSource dùng `audio/note1.wav`, không lặp thêm `assets/` vì đó là tiền tố asset mặc định của audioplayers.
5. Nhấn từng phím nghe cao độ tăng dần; thử nhiều phím khác nhau liên tiếp.
6. Kiểm tra dispose giải phóng các AudioPlayer.

**Đạt khi:** bảy phím có âm khác nhau, đúng thứ tự cao độ, hoạt động sau thao tác chạm trên Web/Android; lỗi audio có thông báo thay vì làm app dừng.

**Giới hạn mẫu:** âm sin phục vụ kiểm chứng phát âm; muốn giống đàn thật, thay WAV bằng mẫu nhạc cụ được phép sử dụng. Mỗi nốt có một player; nhấn lại cùng nốt sẽ phát lại nốt đó, không phải bộ tổng hợp âm chuyên nghiệp.

**Vấn đáp:** tại sao dùng async/await? Tại sao cần dispose? AssetSource và UrlSource khác nhau thế nào?

## 10. Lab 6 — Quizzler

**Mục tiêu:** mô hình dữ liệu, tổ chức mã, tiến trình và kết thúc bài trắc nghiệm.

**File chính:** models/question.dart → data/questions.dart → logic/quiz_controller.dart → screens/home_screen.dart.

**Đã có:** mười câu Đúng/Sai, số câu hiện tại, thanh tiến trình, lịch sử đúng/sai, tổng điểm và nút làm lại.

**Thực hiện:**

1. Đọc Question gồm text và answer; thêm một câu trong data.
2. Controller giữ chỉ số và kết quả. Đọc `isFinished` trước khi truy cập `current` ở UI.
3. Nhấn đáp án: controller chấm câu hiện tại, lưu bool rồi tăng chỉ số.
4. Khi hết câu, UI chuyển sang kết quả, không đọc questions[length].
5. Nhấn làm lại để xóa lịch sử, điểm và quay về câu đầu.
6. Chạy test; tự thử một lượt đúng hết, một lượt sai hết và một lượt trộn đáp án.

**Đạt khi:** mỗi câu được tính một lần; không lỗi RangeError ở cuối; điểm và lịch sử đồng nhất; reset thực sự xóa trạng thái.

**Vấn đáp:** vì sao Question không chứa widget? Tại sao List.unmodifiable bảo vệ lịch sử kết quả? Quy tắc nào thuộc controller, phần nào thuộc UI?

## 11. Lab 7 — Destini

**Mục tiêu:** kể chuyện phân nhánh bằng dữ liệu và chuyển trạng thái.

**Đã có:** câu chuyện hòn đảo tự viết, sáu node, ba kết thúc, hai lựa chọn ở các node trung gian.

**Cấu trúc dữ liệu:** StoryNode chứa đoạn truyện và list StoryChoice; mỗi lựa chọn có text + nextId. Node có choices rỗng là kết thúc.

**Thực hiện:**

1. Vẽ nhánh hoặc đọc bảng dữ liệu trước khi sửa code.
2. Ở node 0 chọn bờ biển đi tới node 1, vào rừng đi tới node 2.
3. Node 1 dẫn tới 3/4; node 2 dẫn tới 3/5. Nodes 3,4,5 là kết thúc.
4. UI sinh nút từ choices. Khi kết thúc, ẩn lựa chọn và hiện Chơi lại.
5. Thử đủ bốn đường: 0→1→3, 0→1→4, 0→2→3, 0→2→5.
6. Chạy test tham chiếu nextId và khởi động lại; nếu thêm node, bảo đảm mọi ID đích đều có thật.

**Đạt khi:** chọn khác nhau tạo nhánh khác nhau, không hiện lựa chọn tại kết thúc, chơi lại về node 0.

**Vấn đáp:** tại sao tổ chức bằng node tốt hơn nhiều if/else chứa cả đoạn văn? Làm sao thêm một kết thúc mà ít sửa UI?

## 12. Lab 8 — BMI Calculator

**Mục tiêu:** UI tương tác nhiều thành phần, widget dùng lại, điều hướng và truyền dữ liệu.

**Đã có:** chọn giới tính, slider chiều cao, tăng/giảm cân nặng và tuổi, màn hình kết quả, phân loại và tính lại. Mẫu giới hạn tuổi từ 20 vì bảng phân loại tham khảo dành cho người lớn 20+.

**Thực hiện:**

1. Đọc CounterCard nhận label/value/callback; dùng lại cho tuổi và cân nặng.
2. Đọc slider 100–220 cm và bước 1 cm; nút cân nặng giới hạn 20–250 kg để minh họa khóa nút ở biên.
3. BMI = kg / (cm / 100)². Không chia trực tiếp cho chiều cao centimet bình phương.
4. BmiCalculator kiểm tra đầu vào dương hữu hạn. Logic riêng này không cần BuildContext.
5. Nút Tính gọi Navigator.push và truyền bmi cho ResultScreen.
6. ResultScreen chỉ làm tròn khi hiển thị; phân loại từ giá trị gốc. Navigator.pop quay lại giữ các giá trị đã chọn.
7. Kiểm tra 170 cm, 65 kg cho khoảng 22,49, hiển thị 22,5; thử biên và quay lại.

Phân loại mẫu: <18,5; 18,5 đến <25; 25 đến <30; ≥30. Tham khảo bảng người lớn CDC: https://www.cdc.gov/bmi/adult-calculator/bmi-categories.html. Đây là ví dụ học lập trình, không phải chẩn đoán. Tuổi/giới tính trong mẫu dùng cho tương tác UI và không tham gia công thức BMI.

**Đạt khi:** phép tính đúng, slider/nút cập nhật state, không có đầu vào 0, kết quả nhận đúng dữ liệu, tính lại giữ form.

**Vấn đáp:** vì sao tách BmiCalculator? Navigator.push/pop làm gì? Vì sao không làm tròn trước khi so sánh ngưỡng?

## 13. Lab 9 — Clima

**Mục tiêu:** quyền thiết bị, Future/async/await, HTTP, JSON và các trạng thái loading/success/error.

**Đã có:** tìm thành phố, lấy vị trí hiện tại, hiển thị tên/nhiệt độ °C/mô tả/độ ẩm/icon, xử lý thiếu key, HTTP 401/429, thành phố không tồn tại, timeout, từ chối quyền và lỗi khác. Không dùng dữ liệu giả để thay cho thời tiết thật.

**Luồng tìm kiếm:** text → Geocoding API → lat/lon → Current Weather API → Weather model → setState → UI.

**Luồng vị trí:** người dùng bấm nút → kiểm tra dịch vụ vị trí → xin quyền khi cần → lấy tọa độ → API thời tiết. Không xin quyền ngay khi mở app; tìm thành phố vẫn dùng được khi không cấp vị trí.

**Thực hiện:**

1. Tạo tài khoản OpenWeather, lấy key và kiểm tra quyền truy cập Current Weather/Geocoding cùng hạn mức hiện tại của tài khoản.
2. Chép secrets.example.json theo README; điền key thật. `--dart-define-from-file` phải được dùng khi chạy/build. Đổi key cần dừng và chạy lại.
3. Đọc Weather.fromJson: temp có thể là số nguyên hoặc số thực, nên cast num rồi toDouble.
4. WeatherService dùng Uri.https để mã hóa tên thành phố; requests có timeout; luôn gửi units=metric.
5. Dùng `Da Nang,VN` hoặc `Hanoi,VN`; mẫu lấy kết quả geocoding đầu tiên nên tên kèm quốc gia sẽ bớt mơ hồ. Chọn trong nhiều kết quả là mở rộng.
6. Kiểm tra spinner và khóa nút lúc tải. Sau await, UI kiểm tra mounted trước setState.
7. Tắt mạng hoặc nhập tên không tồn tại; xem thông báo rồi thử lại bằng nút tìm.
8. Bấm vị trí, thử cho phép/từ chối. Nếu từ chối vĩnh viễn, cấp lại trong Settings/thiết lập trang hoặc dùng tìm tên.
9. Chạy mock test; sau đó phải kiểm tra riêng với key thật và GPS/emulator.

**Quyền Android:** script đã thêm các dòng sau dưới `<manifest>`, bên ngoài `<application>`, trong `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

Dùng main manifest để cả bản release có quyền Internet. Không yêu cầu background location. Emulator cần bật Location và đặt vị trí trong Extended controls nếu chưa có tọa độ. Tài liệu geolocator 14.x nêu compileSdk 35; giữ mặc định Flutter mới nếu đã đáp ứng, không hạ SDK từ bản cao hơn.

**iOS:** script thêm `NSLocationWhenInUseUsageDescription` vào `ios/Runner/Info.plist`. Trên Mac, đối chiếu mục iOS của package geolocator để đặt cấu hình chỉ dùng when-in-use (bao gồm `BYPASS_PERMISSION_LOCATION_ALWAYS=1` trong Podfile nếu áp dụng theo hướng dẫn package). Mẫu chưa cấu hình/phát hành App Store hoặc kiểm chứng iOS. Build bằng Mac/Xcode và kiểm tra quyền trên máy/simulator riêng.

**Web:** vị trí yêu cầu secure context (HTTPS hoặc localhost) và quyền trình duyệt. Chạy qua `flutter run -d chrome`; không mở file build HTML trực tiếp. Có thể thử tìm thành phố trước khi kiểm tra vị trí.

**API key:** secrets.json được gitignore. Truyền bằng dart-define giúp tránh ghi key trực tiếp vào source nhưng không giữ bí mật key trong ứng dụng đã build, nhất là Web. Với sản phẩm thật cần thiết kế proxy phía server và giới hạn truy cập phù hợp; mẫu học tập gọi trực tiếp API.

**Đạt khi:** dữ liệu thật hiển thị đúng đơn vị, cả hai luồng lấy dữ liệu hoạt động trên thiết bị mục tiêu, lỗi không làm treo loading, người từ chối GPS vẫn tìm thành phố được.

**Vấn đáp:** Future là gì? Vì sao không gọi HTTP trong build()? Vì sao cần mounted? HTTP 401 khác 429 ở đâu? Parsing JSON khác cập nhật UI thế nào?

## 14. Kiểm thử và bằng chứng

`verify.ps1` chỉ hỗ trợ kiểm tra tự động; không thay thế thao tác thực tế. Test có sẵn kiểm tra Quizzler kết thúc/reset, Destini tham chiếu node/reset, BMI công thức/biên, Clima parse và lỗi HTTP. Mock test không chứng minh mạng/GPS thật hoạt động.

Cho mỗi lab lưu:

- Ảnh màn hình chính và trạng thái đáng chú ý.
- Video demo ngắn nếu giảng viên yêu cầu.
- README ngắn: mục tiêu, chức năng, cách chạy, kết quả kiểm tra, hạn chế.
- Code nguồn và pubspec.lock; không đóng gói build cache/.dart_tool.

Nếu nộp APK từ thư mục app:

```powershell
flutter build apk --debug
```

Lab 9:

```powershell
flutter build apk --debug --dart-define-from-file=secrets.json
```

APK debug nằm ở `build/app/outputs/flutter-apk/app-debug.apk`, dùng demo/nộp bài nếu được chấp nhận. Phát hành cửa hàng cần cấu hình ký và quy trình riêng.

Build Web:

```powershell
flutter build web
```

Lab 9 thêm `--dart-define-from-file=secrets.json`. Cần phục vụ build/web qua HTTP(S) để kiểm thử đúng, không mở index.html bằng file://.

## 15. Lộ trình học đề xuất

| Buổi | Nội dung | Bằng chứng hoàn thành |
|---|---|---|
| 1 | Môi trường + Lab 1 | App đầu tiên chạy |
| 2 | Lab 2 | Danh thiếp cá nhân |
| 3 | Lab 3 + 4 | State/random hoạt động |
| 4 | Lab 5 | Bảy nốt có âm |
| 5 | Lab 6 | Hoàn thành và reset quiz |
| 6 | Lab 7 | Đi đủ mọi nhánh truyện |
| 7 | Lab 8 | Form/kết quả/điều hướng |
| 8 | Lab 9 | API + GPS + lỗi |
| 9 | Kiểm thử và chuẩn bị nộp | Checklist, ảnh/video, mã nguồn |

Hai mốc Team project trong ảnh không có mô tả. Có thể dành buổi riêng cho đề tài nhóm khi nhận đề; không tự coi một bài lab là bài nhóm.

## 16. Lỗi thường gặp

| Hiện tượng | Cách kiểm tra |
|---|---|
| Không nhận lệnh flutter | PATH, mở terminal mới, flutter --version |
| Không thấy emulator | Khởi động Device Manager, flutter devices |
| Lỗi Android licenses | Cài command-line tools, chạy lệnh chấp nhận license |
| Unable to load asset | Đường dẫn/tên/YAML; pub get và restart |
| pub get không giải được dependencies | Đọc ràng buộc SDK/package; dùng Flutter stable tương thích, không hạ package tùy tiện |
| Test còn tham chiếu MyApp/counter | Đã dùng --empty chưa; chỉ xóa test demo mặc định nếu đang tạo thủ công |
| UI không đổi | Kiểm tra setState và nơi giữ biến |
| RenderFlex overflow | Giảm kích thước cứng, dùng Wrap/scroll/constraints theo chiều cần thiết |
| Không có tiếng | Âm lượng, assets, thao tác chạm trên Web, plugin và restart |
| Clima 401 | Key bị thiếu/sai/chưa kích hoạt hoặc không có quyền API tương ứng |
| Clima luôn spinner | Kiểm tra finally đặt loading=false, timeout và log |
| Vị trí thất bại | Quyền app/trình duyệt, GPS, vị trí emulator, secure context |
| Lỗi khi gọi setState sau await | Kiểm tra mounted trước cập nhật giao diện |

## 17. Tài liệu chính thức

- Flutter cài đặt: https://docs.flutter.dev/install
- Tạo ứng dụng: https://docs.flutter.dev/reference/create-new-app
- CLI: https://docs.flutter.dev/reference/flutter-cli
- Audio: https://pub.dev/packages/audioplayers
- HTTP: https://pub.dev/packages/http
- Vị trí và cấu hình platform: https://pub.dev/packages/geolocator
- Thời tiết: https://openweathermap.org/api/current
- Geocoding: https://openweathermap.org/api/geocoding-api

**Tình trạng bộ mẫu:** chưa chạy Flutter analyze/test/build vì môi trường tạo file không có Flutter SDK. Hãy coi checklist và test đi kèm là bước xác nhận cần thực hiện trên máy của bạn, không phải báo cáo test đã đạt.
