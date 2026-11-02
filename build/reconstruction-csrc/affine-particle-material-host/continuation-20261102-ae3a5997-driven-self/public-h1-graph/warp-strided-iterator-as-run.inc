// SPDX-FileCopyrightText: Copyright (c) 2022 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
// SPDX-License-Identifier: Apache-2.0
template <typename T> struct cub_strided_iterator {
    typedef cub_strided_iterator<T> self_type;
    typedef std::ptrdiff_t difference_type;
    typedef typename std::remove_cv<T>::type value_type;
    typedef T* pointer;
    typedef T& reference;

    typedef std::random_access_iterator_tag iterator_category;

    T* ptr = nullptr;
    int stride = 1;

    CUDA_CALLABLE self_type operator++(int)
    {
        self_type old(*this);
        ++(*this);
        return old;
    }

    CUDA_CALLABLE self_type& operator++()
    {
        ptr += stride;
        return *this;
    }

    CUDA_CALLABLE self_type operator+(difference_type n) const { return self_type(*this) += n; }

    CUDA_CALLABLE self_type& operator+=(difference_type n)
    {
        ptr += n * stride;
        return *this;
    }

    CUDA_CALLABLE self_type operator-(difference_type n) const { return self_type(*this) -= n; }

    CUDA_CALLABLE self_type& operator-=(difference_type n)
    {
        ptr -= n * stride;
        return *this;
    }

    CUDA_CALLABLE difference_type operator-(const self_type& other) const { return (ptr - other.ptr) / stride; }

    CUDA_CALLABLE reference operator*() const { return *ptr; }

    CUDA_CALLABLE reference operator[](difference_type n) const { return *(ptr + n * stride); }

    CUDA_CALLABLE pointer operator->() const { return ptr; }

    CUDA_CALLABLE bool operator==(const self_type& rhs) const { return (ptr == rhs.ptr); }

    CUDA_CALLABLE bool operator!=(const self_type& rhs) const { return (ptr != rhs.ptr); }
};

