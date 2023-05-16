# Identicon Generator
This app generates an unique identicon image based on user's input.
Identicons are visual representations of hashed input values, often used as profile pictures or avatars like profile picture that's generated upon the creation of a github profile.


![image](https://github.com/harisbikovic/identicon-generator/assets/108518278/8ce23d99-a11b-47d2-ae8a-b2191e6cc927)

## Installation and Usage
1. If you don't have Elixir installed on your machine you can install it by following the instructions from the Elixir webpage: _https://elixir-lang.org/install.html_.
2. Clone this repository to your local machine by doing the following:
  - Open a terminal window.
  - Navigate to the directory where you want to download the repository.
  - Execute the following command: `git clone https://github.com/harisbikovic/identicon-generator.git`
3. In the project's root directory compile the project by executing: `iex -S mix`
This will open iex(Interactive Elixir Shell)
4. Once there call the **Identicon.main/1** function passing your desired input(you can type your name) as an argument. For example:
`Identicon.main("harisbikovic")`
5. The identicon image will be generated and saved under the name "identicon_image" in the project directory.
6. To open the image form terminal, exit iex(Ctrl + C twice) and type: `open identicon_image`

![image](https://github.com/harisbikovic/identicon-generator/assets/108518278/2a406fb7-1584-4769-92ee-83e94f700aa1)


## How it works
Here's the explanation of how the app works:
- First the input value is obtained from the user(such as username)
- Hashing: The input value is hashed using the MD5 algorithm provided by the :crypto module. The resulting hash is converted to a hexadecimal string.
- Color Selection: The first three values from the hex string are extracted and used as RGB values to determine the color of the identicon.
- Grid Construction: The remaining characters of the hex string are chunked into groups of three. The rows of the grid are then mirrored by reversing the order of the first two elements.
- Pixel Mapping: Based on the grid configuration, a pixel map is built. Each element in the grid corresponds to a rectangle on the identicon.
- Drawing the Image: The identicon image is created using the :egd library. Each rectangle in the pixel map is filled with the selected color, resulting in the final identicon image.
- Saving the Image: The generated image data is saved to a file named "identicon_image".
 
 
The Identicon application relies on the following dependencies:
- _Elixir_: The programming language used to write the application.
- _Erlang_: The underlying runtime for executing Elixir code.
- _:crypto_: An Erlang module used for hashing input values.
- _:egd_: A library for creating and manipulating graphics in Elixir.



