# I. Basic Docker Command
- **docker build**: build 1 *Image* từ *Dockerfile*
- **docker run**: khởi tạo 1 *Container* từ 1 *Image*, mỗi lần chạy sẽ tạo ra 1 *Container* mới
- **docker exec**: chạy 1 lệnh trong *Container*
- **docker start**: chạy 1 *Container* đang exited
- **docker stop**: dừng 1 *Container* đang up
- **docker logs**: xem logs của 1 *Container*
- **docker ps**: liệt kê các *Container* đang chạy (thêm flag -a/-all giúp liệt kê tất cả các *Container*)
- **docker rename**: đổi tên 1 *Container*
- **docker inspect**: kiểm tra thông tin 1 *Container*
- **docker image ls**: liệt kê các *Image*
- **docker volume ls**: liệt kê các *Volume* 
- **docker rm**: xóa 1 hoặc nhiều *Container*
- **docker rmi**: xóa 1 hoặc nhiều *Image*
- **docker volume rm**: xóa 1 hoặc nhiều *Volume*
- **docker network create**: tạo mới một *Network*

# II. Docker Flow
1. Tạo *Dockerfile*
2. Build *Image* từ *Dockerfile*: **docker build -t AAA .**
- **-t**: đặt tên cho *Image* (tag)
- **.**: build *Image* từ thư mục hiện hành
- **AAA**: tên của *Image*
3. Chạy *Container* dựa trên *Image*: **docker run -dp aaaa:bbbb AAA**
- **-dp**: detach port
- **aaaa**: port của máy tính dùng để chạy ứng dụng
- **bbbb**: port của Docker (check port ở file src/index.js)
- **AAA**: tên của *Image*
- **aaaa:bbbb**: mapping port của máy tính với port của Docker

# III. Push Docker image to Docker Hub
## III.I. Image name đã được đặt đúng theo cú pháp "username/repo-name"
1. Push *Image*: **docker push AAA**
- **AAA**: image name
## III.II. Image name chưa được đặt đúng theo cú pháp "username/repo-name"
1. Clone image hiện tại ra 1 phiên bản mới với tên phù hợp: **docker tag AAA BBB/CCC:DDD**
- **AAA**: image name
- **BBB**: username
- **CCC**: repo-name
- **DDD**: tên commit (optional)
2. Push *Image*: **docker push AAA**
- **AAA**: image name

# IV. Persist data
1. Volumes: Chỉ Docker mới có quyền thay đổi data trong *Volume*. Bảo mật. Muốn có những thay đổi mới trong host (ngoài thư mục mount) bắt buộc phải build lại.
**docker run -dp aaaa:bbbb -v cccc:dddd AAA**
- **-v** / **--volume**: gắn *Volume* vào *Container* 
- **cccc**: tên của *Volume*
- **dddd**: đường dẫn trong *Container* tới thư mục cần mount
- **AAA**: tên của *Image*
2. Bind mount: Những tiến trình không phải Docker vẫn có quyền thay đổi data. Kém bảo mật. Những thay đổi mới trong host sẽ được lưu trữ lại liên tục.
* Sử dụng **-v** flag hoặc **--volume** flag: Docker sẽ tự tạo folder ở máy host nếu folder không tồn tại
**docker run -v -dp aaaa:bbbb CCCC:DDDD EEEE**
  - **-dp**: detach port
  - **aaaa**: port của máy tính dùng để chạy ứng dụng
  - **bbbb**: port của Docker (check port ở file src/index.js)
  - **CCCC**: đường dẫn của folder phía máy host (input)
  - **dddd**: đường dẫn của folder phía lưu trữ (storage)
  - **EEEE**: tên của *Image*
* Sử dụng **--mount** flag: Folder phía máy host buộc phải tồn tại. Nếu folder không tồn tại sẽ gây ra lỗi
**docker run -dp aaaa:bbbb --mount type=bind,source=CCCC,target=DDDD EEEE**
  - **-dp**: detach port
  - **aaaa**: port của máy tính dùng để chạy ứng dụng
  - **bbbb**: port của Docker (check port ở file src/index.js)
  - **CCCC**: đường dẫn của folder phía máy host (input)
  - **dddd**: đường dẫn của folder phía lưu trữ (storage)
  - **EEEE**: tên của *Image*

# V. Docker Network
1. Tạo mới một *Network*: **docker network create AAA**
- **AAA**: tên *Network*
2. Kết nối *Container* với *Network* vừa tạo: **--network AAA**
- **AAA**: tên *Network*

