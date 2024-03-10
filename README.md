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

Leave the rest Default, hit `Create distribution`



