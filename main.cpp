#include <iostream>
#include <ctime>


void init_Random_Particles(ObjectParticle *&object_Particles, int pariticle_number) {
    srand((unsigned) time(NULL));//初始化随机数种子 

    for (int i = 0; i < pariticle_number; i++) {
        object_Particles[i].m = rand() / double(RAND_MAX) * MAX_M;
        object_Particles[i].vx = rand() / double(RAND_MAX) * MAX_V * 2 - MAX_V / 2;
        object_Particles[i].vy = rand() / double(RAND_MAX) * MAX_V * 2 - MAX_V / 2;
        object_Particles[i].vz = rand() / double(RAND_MAX) * MAX_V * 2 - MAX_V / 2;
        object_Particles[i].px = rand() / double(RAND_MAX) * MAX_P * 2 - MAX_P / 2;
        object_Particles[i].py = rand() / double(RAND_MAX) * MAX_P * 2 - MAX_P / 2;
        object_Particles[i].pz = rand() / double(RAND_MAX) * MAX_P * 2 - MAX_P / 2;
        object_Particles[i].ax = 0;//rand() / double(RAND_MAX)*MAX_A * 2 - MAX_A / 2;
        object_Particles[i].ay = 0;// rand() / double(RAND_MAX)*MAX_A * 2 - MAX_A / 2;
        object_Particles[i].az = 0;// rand() / double(RAND_MAX)*MAX_A * 2 - MAX_A / 2;
        object_Particles[i].ax_up = 0;
        object_Particles[i].ay_up = 0;
        object_Particles[i].az_up = 0;
    }
}


int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;

}


