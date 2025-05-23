using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FootSteps : MonoBehaviour
{
    public AudioClip[] footStepClips;
    private AudioSource audioSource;
    private Rigidbody _rigidbody;
    public float footStepThreshold;
    public float footStepRate;
    private float footStepTime;

    // Start is called before the first frame update
    void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
        audioSource = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        if(Mathf.Abs(_rigidbody.velocity.y)<0.1f)
        {
            if(_rigidbody.velocity.magnitude > footStepThreshold)
            {
                if(Time.time - footStepTime > footStepRate)
                {
                    footStepTime = Time.time;
                    audioSource.PlayOneShot(footStepClips[Random.Range(0, footStepClips.Length)]);
                }
            }
        }
    }
}
