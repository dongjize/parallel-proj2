#include <iostream>
#include <ctime>
#include <cmath>


long double G;

void init_Random_Particles(ObjectParticle *&object_Particles, int particle_number) {
    srand((unsigned) time(NULL));//初始化随机数种子 

    for (int i = 0; i < particle_number; i++) {
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


        //更新加速度的增量
        for (int i = 0; i < particle_number; i++)
            for (int j = i + 1; j < particle_number; j++)
                change_Particle_aup(object_Particles[i], object_Particles[j]);
    }
}

//通过万有引力修改1粒子相互作用下加速度的增量
void change_Particle_aup(ObjectParticle &object1, ObjectParticle &object2) {
    //距离的平方，其中还没有除于基数平3ci方的MAX_Basic_Meter^3
    long double distance_between_pow3 = 1;
    long double dx, dy, dz;
    dx = object2.px - object1.px;
    dy = object2.py - object1.py;
    dz = object2.pz - object1.pz;
    distance_between_pow3 = dx * dx + dy * dy + dz * dz;
    distance_between_pow3 = pow(sqrt(distance_between_pow3), 3);//求得其三次方

    //Fx=GMmdx/(r^3),ax=Fx/m  此处获得G/r^3
    long double tmp = G / distance_between_pow3;
    //修改粒子1加速度增量
    long double Fa_tmp1 = tmp * object2.m;
    object1.ax_up += Fa_tmp1 * dx;
    object1.ay_up += Fa_tmp1 * dy;
    object1.az_up += Fa_tmp1 * dz;
    //同理修改粒子2
    long double Fa_tmp2 = tmp * object1.m;
    object2.ax_up -= Fa_tmp2 * dx;
    object2.ay_up -= Fa_tmp2 * dy;
    object2.az_up -= Fa_tmp2 * dz;

    //更新粒子状态
    for (int i = 0; i < particle_Number; i++) {
        //Acceleration  velocity shift
        long double t_tmp = time_beats;
        update_velocity(object_Particles[i], t_tmp);//更新速度
        update_shift(object_Particles[i], t_tmp);//更新位移
        update_acceleration_up(object_Particles[i], t_tmp);//更新加速度增量
    }

}

int main() {


    std::cout << "Hello, World!" << std::endl;
    return 0;

}


