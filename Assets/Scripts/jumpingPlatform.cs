using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class jumpingPlatform : MonoBehaviour
{
    float power = 100.0f;

    private void OnCollisionEnter(Collision collision)
    {
        Rigidbody playerRb = collision.collider.GetComponent<Rigidbody>();
        if (playerRb != null)
        {
            Debug.Log("충돌 감지: " + collision.gameObject.name);

            playerRb.AddForce(transform.up * power, ForceMode.Impulse);
        }
    }
}
