/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test_numerical_analysis;

/**
 *
 * @author Jrincon
 */
class Intervalo {
    
    float a;
    float b;
    public Intervalo(float a, float b){
        this.a = a;
        this.b = b;
    }
    
    public void setA(float a){
        this.a=a;
    }
    public void setB(float b){
        this.b = b;
    }
    
    public float getA(){
        return this.a;
    }
    public float getB(){
        return this.b;
    }
}
