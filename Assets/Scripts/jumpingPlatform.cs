using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class jumpingPlatform : MonoBehaviour
{
    float power = 100.0f;

    private void OnCollisionEnter(Collision collision)
    {
        //충돌하는 플레이어의 rigidbody를 가져와서 점프처리
        Rigidbody playerRb = collision.collider.GetComponent<Rigidbody>();
        if (playerRb != null)
        {
            playerRb.AddForce(transform.up * power, ForceMode.Impulse);
        }
    }
}
