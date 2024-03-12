# AWS Cloud Resume Challenge
Here is my full write-up solution to the [Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge/aws/) (AWS version).

Check out my [website](https://www.haerowin.com/) and give me a feedback!

## Prerequisites
Here are a few things you need to have before starting this challenge,

1. An AWS account. If you don't have one, [sign up](https://www.google.com/aclk?sa=l&ai=DChcSEwjopKf7u-iEAxUTlFAGHVNWBDgYABAAGgJkZw&ase=2&gclid=Cj0KCQiArrCvBhCNARIsAOkAGcX0mC1-u3qoVk9Ajdv5BtOpq1LsUDUrzAOmzDT0lYP1i9sJ9Z5BMCIaAtErEALw_wcB&ei=wwLtZcPWC5nUp84PpfO3iAE&sig=AOD64_0F3c3XKZEL8-3y_gM80U1ke0gPuQ&q&sqi=2&nis=4&adurl&ved=2ahUKEwiDxJv7u-iEAxUZ6skDHaX5DREQ0Qx6BAgIEAE) for a free-tier account today.
2. A Domain, you can purchase from any provider but I'd recommend buying from [Amazon Route 53](https://aws.amazon.com/route53/) because it will be easier to set up. I got mine for only $13/year.
3. A few dollars in case AWS charges you for no reason...  

## 1. Certification
You can skip this step, you can complete this challenge without an AWS certificate, just like me :)

## 2. HTML
You will need to build your Resume using HTML. I just copied what I have from my [LinkedIn Resume](https://www.linkedin.com/in/duyvduong/overlay/1709142758767/single-media-viewer/?profileId=ACoAACzMK_ABDOQvcZj5mNttrWv0ta-PtTt-bqY) written in Word.

## 3. CSS
Make it colorful! You can check out my Resume at <em>/website/index.html</em>. I built it using CSS, JS, and [Bootstrap](https://getbootstrap.com/docs/5.3/getting-started/download/).

## 4. Static Website
### Create a new S3 bucket
1. Go to [AWS S3](https://aws.amazon.com/s3/)
2. Hit `Create bucket`
3. Under <b>General configuration</b>, choose a bucket name, eg. <em>diidduong-crc</em>. Name it simple but unique because the name is global.
4. Under <b>Object ownership</b>, choose <em>ACLs enabled</em> -> Bucket owner preferred.

You can leave the rest default, hit `Create bucket`. Your bucket should be created!


### Upload your Resume

1. Open your bucket
2. Hit `Upload`
3. Hit `Add files`
4. Select all your Resume files
5. Hit `Upload`

### Turn on Static Website Hosting
1. Open your bucket
2. Go to `Properties` tab and scroll down to the bottom
3. Under <b>Static website hosting</b>, hit `Edit`
- Static website hosting: choose <em>Enable</em>
- Hosting type: choose <em>Host a static website</em>
- Index document: enter your resume filename, eg. <em>index.html</em>
4. Hit `Save changes`

You should see a <em>S3 URL</em> generated, but it is not accessible because the default S3 setting blocks ALL public access. We'll use CloudFront to safely direct users to our static website. 

## 5. HTTPS
### Create a CloudFront distribution
1. Go to [Amazon CloudFront](https://aws.amazon.com/cloudfront/)
2. Hit `Create distribution`
3. Under <b>Origin</b>
- Origin domain: select your S3 URL generated in the previous step, eg. <em>diidduong-crc.s3.amazonaws.com</em>, leave the rest as Default
- Origin access: select <em>Origin access control settings (recommended)</em>, CloudFront will provide a policy for you to attach to your S3 bucket to allow CloudFront to access your S3 resources
4. Under <b>Viewer</b>
- Viewer protocol policy: select <em>HTTPS only</em>

Leave the rest Default, hit `Create distribution`. Your CloudFront distribution should be created! Open it and you will see a generated <em>Distribution domain name</em> which is your <em>CloudFront URL</em>. But you will get 403 Forbidden error if you access the url because it is a secure protocol (HTTPS) that requires an SSL certificate.


## 6. DNS
Since I'm using Route 53 for my custom domain, here are steps to connect it to our Cloud Front distribution.
### Create Custom SSL Certificate
1. Go to [Amazon CloudFront](https://aws.amazon.com/cloudfront/)
2. Open the distribution you just created, hit `Edit` under <b>Settings</b> tab
3. Add two CNAME, `website.com` and `www.website.com`
4. Under <b>Custom SSL certificate - optional</b>, hit `Request certificate`, leave the Cloud Front tab open, we will come back later when we have the certificate
5. We will <em>Request a public certificate</em>, enter both domains `website.com` and `www.website.com` as fully qualified domain name
6. Under <b>Validation method</b>, choose <em>Email validation</em> since it will be quick and simple, just by opening a link from your email and approving it
7. Hit `Request`. You should receive an email with an instruction link. Note: Check your spam folder if you don't see any new emails.
8. After you approve, go back to the Cloud Front tab and refresh it. You will see your new certificate there. Select it
9. Under <b>Default root object</b>, enter <em>index.html</em>
10. Hit `Save changes`

### Create a record in Route 53 Hosted Zone for Cloud Front distribution
1. Go to [Amazon Route53](https://aws.amazon.com/route53/) Hosted zones section
2. Open your zone, eg. `website.com`
3. Hit `Create record`
4. Under Record name, enter `www` as your subdomain name for your domain
5. Under Record Type, choose <em>A – Routes traffic to an IPv4 address and some AWS resources</em>
6. Enable <em>Alias</em>
7. Route traffic to <em>Alias to Cloud Front distribution</em> and choose your distribution created from step 5.
8. Hit `Create records`

Go to your domain, eg. `https://www.wesbite.com` and you should see your Resume!

