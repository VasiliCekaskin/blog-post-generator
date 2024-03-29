# Project README

This project is a blog post generator that uses GPT-3.5 Turbo, an advanced language model, to create blog posts based on JSON prompts. The generated blog posts are then saved to disk. The project is structured into several modules, each responsible for specific functionalities.

## Code Files Overview

1. `bin/application`: This file is the main entry point of the application. It requires the necessary files and starts the blog post generator.

2. `lib/app/blog_post_generator/main.rb`: This file contains the main logic for the blog post generator. It uses the configurations to prompt the user for a blog post, generate it using GPT-3.5 Turbo, and save it to disk.

3. `lib/app/blog_post_generator/config.rb`: This file holds the configuration settings for the blog post generator. It specifies paths, access tokens, and other necessary details.

4. `lib/app/logger.rb`: This file defines a simple logging mechanism for the application. It provides methods to log informational and error messages.

5. `lib/app/blog_post_generator/prompt_result.rb`: This file defines the `PromptResult` class, which is a base class for prompt results returned by the GPT-3.5 Turbo API.

6. `lib/app/blog_post_generator/blog_post.rb`: This file contains the `BlogPost` class, responsible for representing and saving blog posts generated by the application.

7. `lib/app/blog_post_generator/blog_post_prompt.rb`: This file defines the `BlogPostPrompt` class, which prompts the user for a blog post using GPT-3.5 Turbo based on a predefined JSON format.

8. `lib/app/blog_post_generator/blog_post_prompt_result.rb`: This file defines the `BlogPostPromptResult` class, which extends `PromptResult` to transform the raw prompt result data into a structured blog post format.

9. `lib/app/blog_post_writers/disk.rb`: This file implements the `Disk` blog post writer class responsible for saving blog posts to disk.

10. `lib/app/prompt_clients/chat_gpt.rb`: This file defines the `ChatGPT` prompt client class, which interacts with the GPT-3.5 Turbo API to prompt for blog posts.

## Usage

To use this blog post generator, you need to provide JSON prompts with the required blog post information. Run the `bin/application` script to start the generator. The application will prompt you for a blog post using the predefined JSON format, generate the blog post with GPT-3.5 Turbo, and save it to disk.

## Dependencies

This project has external dependencies on OpenAI's GPT-3.5 Turbo API. Ensure you have an access token for GPT-3.5 Turbo and set it appropriately in the `Config` class.

## Extend the Project

To extend the project, you can consider the following improvements:

1. Implement different blog post writers: Currently, the project supports writing blog posts to disk only. You can add support for other storage options like databases, cloud storage, etc.

2. Enhance the prompt client: The project currently uses the ChatGPT prompt client to interact with GPT-3.5 Turbo. You can explore other prompt clients or customize the behavior of the existing one.

3. Implement error handling: The application currently catches exceptions during blog post generation. You can improve error handling and provide more informative error messages to the user.

4. Add unit tests: Write unit tests to ensure the stability and correctness of the different components of the application.

5. Improve logging: Extend the logging mechanism to provide more detailed information during the blog post generation process.

By making these improvements, you can create a more robust and flexible blog post generator.

## License

This project is licensed under the [MIT License](LICENSE).

Feel free to modify, distribute, and use it as per the terms of the license.
