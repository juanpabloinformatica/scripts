# Description

## Goal

- Upload videos to youtube
- Automatic process once I have wi-fi connection
- Ask if I want to upload or not the video.
- Remind if there are videos that has not been pushed yet
- Organize videos according to playlist

## Steps

- Check youtube API:

  - Check PUT request
    - For adding the video
  - Check for GET request
    - For getting the video with certain timestamp to check if
      there are videos not published yet
  - Check for playlist API section

- Cron-tab:
  - Checks is there are videos that has not been loaded for some reason

## ideas

- Using fzf for fuzzy selecting
- Table displayed by fzf ??

| video_name | video_type | video_timestamp |
| ---------- | ---------- | --------------- |
|            |            |                 |
|            |            |                 |
|            |            |                 |

## Thinking process

- As I have different kind of videos I will have to do a find command taking in account the timestamp,
  in such a way I will know the kind of video

### Upload video workflow

- main ->
  identify_video_type_x_day
  -----videos_x_day------>
  for v in videos_x_day check_if_not_uploaded
  -------videos_x_not_uploaded-------->
  for v in videos_x_day_not_uploaded get_correct_playlist ((display videos with fzf and in the form of column))
  ---playlist---->
  upload_video(playlist)

### Trigerring process

- cron-tab
  ------>
  check if wifi connection
  --- true --->
  if wifi_connection:
  ask_for uploading_videos?
  ---- true ---->
  call upload_video_workflow

### reminder process

- cron-tab
  ----->
  videos*n_uploaded:list = []
  for v in videos:
  if get_video_api_youtube == 200:
  continue
  else:
  videos_n_uploaded.push(v)
  ---->
  for v in videos_n_uploaded: ((display videos with fzf and in the form of column))
  <!-- ask_upload --- true ---> -->
  
