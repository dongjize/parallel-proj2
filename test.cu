#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <time.h>
#include <iostream>

using namespace std;
using namespace cv;


int main() {
    clock_t t1 = clock();

    int num_devices = cv::cuda::getCudaEnabledDeviceCount();

    if (num_devices <= 0) {
        cerr << "There is no device." << endl;
        return -1;
    }

    int enable_device_id = -1;
    for (int i = 0; i < num_devices; i++) {
        cv::cuda::DeviceInfo dev_info(i);
        if (dev_info.isCompatible()) {
            enable_device_id = i;
        }
    }

    if (enable_device_id < 0) {
        cerr << "GPU module isn't built for GPU" << endl;
    }

    cv::cuda::setDevice(enable_device_id);

    Mat src_image = imread("Hi-RGB0971.tif");
    Mat dst_image;
    cuda::GpuMat d_src_img(src_image);//upload src image to gpu
    cuda::GpuMat d_dst_img;
    cuda::cvtColor(d_src_img, d_dst_img, CV_BGR2GRAY);
    d_dst_img.download(dst_image);
    imshow("test", dst_image);

    clock_t t2 = clock();

    std::cout << "time: " << (t2 - t1) / 1000 << "s" << endl;

    waitKey();

    return 0;

}